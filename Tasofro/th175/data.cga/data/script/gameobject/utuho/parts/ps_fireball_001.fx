Texture2D tex0: register(t0);
SamplerState s0 : register(s0);

Texture2D tex1: register(t1);
SamplerState s1 : register(s1);

cbuffer ConstBuff : register(b0)
{
	float f;
};

struct PS_INPUT
{
	float4 position : SV_POSITION;
	float4 color : COLOR;
	float2 texcord : TEXCOORD0;
	float psize : PSIZE;
};

float4 main(PS_INPUT input) : SV_Target
{
	float2 cord_n = input.texcord * 2.0 - 1.0;
	float dist = sqrt(pow(cord_n.x, 2) + pow(cord_n.y, 2));
	
	float f2 = floor(f * 50);
	f2 = f2 / 50;

	float2 pick_uv = 0;
	if (dist < 1.0)
	{
		float angle = atan2(cord_n.y, cord_n.x);
		float r = pow(dist, 2.0);
		pick_uv.x = (cos(angle) * r + 1.0) * 0.5;
		pick_uv.y = (sin(angle) * r + 1.0) * 0.5;
		
		input.texcord.x = ((angle / 3.141592653589793238462643 + 1.0) * 0.5) % 1.0;
		input.texcord.y = dist % 1.0;
	} else {
		discard;
	}


	float src_u1 = input.texcord.x;
	float src_v1 = (input.texcord.y + f2) % 1;
	float4 col1 = tex1.Sample(s1, float2(src_u1, src_v1));// * input.color;

	float src_u2 = (input.texcord.x);
	float src_v2 = (input.texcord.y + f2  / 2.0) % 1;
	float4 col2 = tex1.Sample(s1, float2(src_u2, src_v2));// * input.color;

	float4 col = ((col1 * 1.4 + col2 * 1.0) - (1.0 - input.texcord.y) * 0.7) * input.texcord.y;

	if (input.texcord.y > 0.8)
	{
		col += float((input.texcord.y - 0.8) * 5.0) * 0.5;
	}

	if (col.r < 0.5)
	{
		col *= col.r;
//		col = float4(0, 0, 0, 1);
	}

	float col_dist = (1.0 - dist * 0.9) * (cos(f * 8) * 0.15 + 0.85);
	col = float4(col_dist, col_dist * 0.2, col_dist * 0.1, 1) + col * input.color;


	if (dist > 0.91)
	{
		if (tex1.Sample(s1, input.texcord).r > 0.3)
		{
			col.r = 0.0;
			col.g = 0.0;
			col.b = 0.0;
			col.a = 1.0;//col.a * 0.5;
		} else {
			if (dist >= 0.97)
			{
				col.a = 0.0;
			}
		}
/*
	} else
	if (dist > 0.93)
	{
		col.a = 1.0 - (dist - 0.95) / 0.05;
		col.r += col.a * 2.0;
		col.g = col.a * 0.2;
		col.b = col.a * 0.1;
*/
	} else
	if (dist < 0.95)
	{
		col.a = input.color.a;//1.0;
	}

	col.rgb = floor(col.rgb * 3);
	col.rgb /= 3;
	
//	col.a *= input.color.a;

	return col;
}
