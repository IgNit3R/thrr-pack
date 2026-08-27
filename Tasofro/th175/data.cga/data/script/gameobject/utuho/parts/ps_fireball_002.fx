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
	
	float f2 = floor(f * 40);
	f2 = f2 / 40;
	
	float2 pick_uv = 0;
	if (dist < 1.0)
	{
		float angle = atan2(cord_n.y, cord_n.x);
		float r = pow(dist, 2.0);
		pick_uv.x = (cos(angle) * r + 1.0) * 0.5;
		pick_uv.y = (sin(angle) * r + 1.0) * 0.5;
		
		input.texcord.x = (angle / 3.1415926535 + 1.0) * 0.5;
		input.texcord.y = 1.0 - dist;
	} else {
		discard;
	}


	float src_u1 = input.texcord.x;
	float src_v1 = (input.texcord.y + f2) % 1;
	float4 col1 = tex1.Sample(s1, float2(src_u1, src_v1));// * input.color;

	float src_u2 = (input.texcord.x);
	float src_v2 = (input.texcord.y + f2  / 2.0) % 1;
	float4 col2 = tex1.Sample(s1, float2(src_u2, src_v2));// * input.color;

	float4 col = ((col1 * 1.6 + col2 * 1.0) - (1.0 - input.texcord.y) * 0.7) * input.texcord.y;
	if (dist < 0.5)
	{
		col += 1.0 - dist * 2.0;
	}

	if (col.r < 0.5)
	{
		col *= col.r;
//		col = float4(0, 0, 0, 1);
	} else {
		col.r += col.r * 0.5;
	}

	col = floor(col * 2);
	col /= 2;
//	return col;

	if (input.texcord.y > 0.8)
	{
		col += float((input.texcord.y - 0.8) * 5.0) * 0.5;
	}

	
	col.a *= col.a;

	return col * input.color;

}
