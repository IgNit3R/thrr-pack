Texture2D tex0: register(t0);
SamplerState s0 : register(s0);

Texture2D tex1: register(t1);
SamplerState s1 : register(s1);

static float resolution_x = 640.0;
static float resolution_y = 360.0;

static float src_w = 777.0;
static float src_h = 389.0;

static float power = 100.5;
static float wave_offset = 0.5;

cbuffer ConstBuff : register(b0)
{
//	float line_pow;
	float border_x;
};

struct PS_INPUT
{
	float4 position : SV_POSITION;
	float4 color : COLOR;
	float2 texcord : TEXCOORD0;
};

float4 main(PS_INPUT input) : SV_Target
{
	float2 screen_pos;
	screen_pos.x = input.position.x / resolution_x;
	screen_pos.y = input.position.y / resolution_y;
	
	float px_size = 1.0 / src_w;
	float py_size = 1.0 / src_h;

	float sx = screen_pos.x + screen_pos.y / 2.0;
	if (sx > border_x)
	{
		discard;
	}
	
	float line_pow;

	if (sx < border_x - 0.25)
	{
		line_pow = 1.0;
	} else {
		line_pow = (border_x - sx) * 4.0;
	}


	float4 ave, center_c;
	int cnt = 0;

	for (int y = -8; y <= 8; y++)
	{
		for (int x = -8; x <= 8; x++)
		{
			float4 ite_c = tex0.Sample(s0, input.texcord + float2(px_size * x, py_size * y));
			ave += ite_c;
			if (x == 0 && y == 0)
			{
				center_c = ite_c;
			}
			cnt++;
		}
	}
	
	ave /= cnt;

	float4 out_color;// = tex0.Sample(s0, input.texcord);

	if (ave.r > line_pow)
	{
		out_color = float4(1,1,1,1);//tex0.Sample(s0, input.texcord);
//		discard;
	} else {
		out_color = center_c;// / (ave);
	}

	float4 out_color1 = tex1.Sample(s1, screen_pos);
	out_color1 = 1.0 - ((1.0 - out_color1) / out_color);
	if (out_color.r <= 0.1) out_color1.rgb = 0.0;

	out_color1.a = saturate(line_pow * 2.0);//input.color.a;
	
//	out_color1.a *= 0.5;

	return out_color1;
}
