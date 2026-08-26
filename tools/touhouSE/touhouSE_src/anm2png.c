#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <time.h>
#include "lib.c"
#include "png.c"


struct dat_data{
	int size;
	int list_size;
	int comp_lsize;
	int list_num;
};

typedef struct region{
	int id;
	float left;
	float top;
	float right;
	float bottom;
}REGION;

typedef struct attr{
	unsigned short type;
	unsigned short len;
	int addr;
}ATTR;

struct dat_data th11dat;

int getnbit(unsigned char *s,int *a,int len){
	unsigned char map[40],*b;
	int i,l,t,max;

	max = ((*a%8)+len)/8 + 1;

	i = *a;
	*a += len;
	s += i/8;
	i = i%8;
	t = i;

	l = 0;
	while(l < max){
		while(i < 8){
			map[l*8+i-t] = (s[l]&(1<<(7-i)))>>(7-i);
			i++;
		}
		i = 0;
		l++;
	}

	i = len;
	t = 0;
	while(i > 0){
		i--;
		t += map[len-i-1]<<i;
	}

	return t;
}
#define getbit(x,y)	getnbit(x,y,1)

#define DICT_SIZE 0x2000
void decomp(unsigned char *in,int in_size,unsigned char *out,int out_size){
	unsigned char dict[DICT_SIZE],*o;
	unsigned int dictop = 1;
	int b = 0,c,i;
	int patofs,patlen;

	o = out;
	memset(dict, 0, DICT_SIZE);
	while(1){
		if(getnbit(in,&b,1)) {
			c = getnbit(in,&b,8);
			if(o-out >= out_size){return;}
			*o = c;
			o++;
			dict[dictop % DICT_SIZE] = c;
			dictop++;
		} else {
			patofs = getnbit(in,&b,13);
			if(!patofs)return;
			patlen = getnbit(in,&b,4) + 3;
			for(i = 0; i < patlen; ++i){
				c = dict[(patofs + i) % DICT_SIZE];
				if(o-out >= out_size){return;}
				*o = c;
				o++;
				dict[dictop % DICT_SIZE] = c;
				dictop++;
			}
		}
	}
}

void thcrypter(unsigned char *data,int size,unsigned char key,unsigned char step,int block,int limit){
	unsigned char *map,*in,*out;
	int addup;
	int i,j;

	//printf("%d\t%x\t%x\t%x\t%x\n",size,key,step,block,limit);

	addup = size % block;
	if(addup >= block / 4) addup = 0;
	addup += size % 2;
	size -= addup;

	map = malloc(block);
	while(size > 0 && limit > 0) {
		if(size < block)block = size;
		memcpy(map,data,block);
		in = map;
		j = 1;
		while(j < 3){
			out = data+block-j;
			i = 0;
			while(i < block / 2){
				*out = *in ^ key;
				in++;
				out -= 2;
				key += step;
				i++;
			}
			j++;
		}
		data += block;
		limit -= block;
		size -= block;
	}
	free(map);
}



void read_region(char *head,int num,char *p,char *filename,int x,int y,int add){
	REGION reg;
	int addr,i;
	char fn[256];
	FILE *fp;

	strcpy(fn,filename);
	strcpy(&fn[strlen(fn)-4],".txt");
	if(add){
		fp = fopen2(fn,"a");
	} else {
		fp = fopen2(fn,"w");
		fprintf(fp,"//id\tleft\ttop\tright\tbottom\n");
	}
	i = 0;
	while(i < num){
		addr = *(int *)&head[i*4];
		memcpy(&reg,p+addr,sizeof(REGION));
		fprintf(fp,"%d\t%.0f\t%.0f\t%.0f\t%.0f\n",reg.id,reg.left+x,reg.top+y,reg.right,reg.bottom);
		i++;
	}
	fclose(fp);
}

void read_attr(ATTR *attr,int num,char *base,char *filename){
	int i;
	char fn[256];
	FILE *fp;

	strcpy(fn,filename);
	strcpy(&fn[strlen(fn)-4],".attr");
	fp = fopen2(fn,"w");
	i = 0;
	while(i < num){
		fprintf(fp,"%d\t%d\t0x%08x\n",attr[i].type,attr[i].len,attr[i].addr);
		i++;
	}
	fclose(fp);
}

PNG *col_sum(char *fn,COLOR *col,int w,int h,int w2,int h2){
	PNG *png;
	COLOR *c,*p,*a;
	int x,y,i,l;

	png = load_png(fn);
	if(png == NULL){
		png = malloc(sizeof(PNG));
		png->col = NULL;
		png->w = 0;
		png->h = 0;
		png->cn = 32;
		png->pal = NULL;
	}
	x = w2+w;
	y = h2+h;
	if(png->w > x)x = png->w;
	if(png->h > y)y = png->h;

	c = malloc(x*y*sizeof(COLOR));
	memset(c,0,x*y*sizeof(COLOR));
	if(png->col != NULL){
		i = 0;
		p = c;
		a = png->col;
		while(i < png->h){
			memcpy(p,a,png->w*sizeof(COLOR));
			p += x;
			a += png->w;
			i++;
		}
	}
	i = 0;
	p = c+w2+h2*x;
	a = col;
	while(i < h){
		memcpy(p,a,w*sizeof(COLOR));
		p += x;
		a += w;
		i++;
	}

	if(png->col != NULL)free(png->col);
	png->col = c;
	png->w = x;
	png->h = y;
	return png;
}
void th11img_convert(char *data,int size,char *filename){
	int w2,h2,w,h,i,l,len,cn,type;
	unsigned char *str,*str2,*s,*base,fn[256];
	COLOR *col,*c;
	FILE *fp;
	PNG *png,*t;

	//printf("%s\n",filename);
	s = data;
	while(s-data < size){
		//w2 = *(short *)&s[0x0A];
		//h2 = *(short *)&s[0x0C];
		strcpy(fn,s + *(int *)&s[0x10]);
		if(strcmp(&fn[strlen(fn)-4],".png") == 0){
			base = s;
			w2 = *(short *)&s[0x14];
			h2 = *(short *)&s[0x16];
			//printf("\t%s\t%d\t%d\t%d\t%d\n",fn,w2,h2,*(short *)&s[0x14],*(short *)&s[0x16]);
			//read_attr((ATTR*)&s[0x40+*(short *)&s[0x04]*4],*(short *)&s[0x06],s,fn);

			str = s + *(int *)&s[0x1C];

			if(strncmp(str,"THTX",4) != 0)return;
			type = *(short *)&str[6];
			w = *(short *)&str[8];
			h = *(short *)&str[10];
			len = *(int*)&str[12];
			str += 16;
			col = malloc(sizeof(col)*w*h);

			l = 0;
			if(type == 1){
				while(l < w*h){
					col[l].b = str[0];
					col[l].g = str[1];
					col[l].r = str[2];
					col[l].alpha = str[3];
					str+=4;
					l++;
				}
			} else if(type == 5){
				while(l < w*h){
					col[l].b = (str[0]&0x0F) << 4;
					col[l].g = str[0]&0xF0;
					col[l].r = (str[1]&0x0F) << 4;
					col[l].alpha = str[1]&0xF0;
					str+=2;
					l++;
				}
			} else if(type == 3){
				while(l < w*h){
					col[l].b = (str[0]&0x1F) << 3;
					col[l].g = ((str[0]&0xE0) >> 3) + ((str[1]&0x07) << 5);
					col[l].r = str[1]&0xF8;
					col[l].alpha = 0xFF;
					str+=2;
					l++;
				}
			} else {
				printf("%s:unknown format(%d)\n",fn,type);
				while(l < w*h){
					col[l].b = str[0];
					col[l].g = str[1];
					col[l].r = 0;
					col[l].alpha = 0xFF;
					str+=2;
					l++;
				}
			}
			if(w2+h2 > 0 && NULL != (png = col_sum(fn,col,w,h,w2,h2)) ){
				//read_region(&base[0x40],*(short *)&base[0x04],base,fn,w2,h2,1);
				pngout(png->w,png->h,png->w,(char *)png->col,fn,png->cn);
				free(png->col);
				free(png);
			} else {
				//read_region(&base[0x40],*(short *)&base[0x04],base,fn,w2,h2,0);
				/*fp = fopen(fn,"rb");
				while(fp != NULL){
					strcpy(&fn[strlen(fn)-4],"_.png");
					fclose(fp);
					fp = fopen(fn,"rb");
				}*/
				pngout(w,h,w,(char *)col,fn,32);
			}
			free(col);
		}
		if(*(int *)&s[0x24]==0)break;
		s += *(int *)&s[0x24];
	}
}

void th11_putfile(char *data,int size,char *fn){
	FILE *fp;

	if(strcmp(&fn[strlen(fn)-4],".anm") == 0){
		th11img_convert(data,size,fn);
	}
}


void put(char *fn){
	FILE *fp;
	char *data;
	int size;

	fp = fopen(fn,"rb");
	fseek(fp,0,SEEK_END);
	size = ftell(fp);
	fseek(fp,0,SEEK_SET);

	data = malloc(size);
	fread(data,1,size,fp);
	fclose(fp);
	th11_putfile(data,size,fn);
	free(data);
}


int main(int argc,char *argv[]){
	int i;

	if(argc < 2)return 0;
	SetAppDir();

	i = 1;
	while(i < argc){
		put(argv[i]);
		i++;
	}
	return 0;
}


