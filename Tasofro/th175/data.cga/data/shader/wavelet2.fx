Texture2D g_tex: register(t0);
SamplerState g_sampler : register(s0);

cbuffer ConstBuff : register(b0)
{
	int frame;
	float wa;
};

struct PS_INPUT
{
	float4 Pos : SV_POSITION;
	float4 Col : COLOR;
	float2 TexCd : TEXCOORD0;
};

float4 PS(PS_INPUT input) : SV_Target
{
	float2 cord = input.TexCd - 0.5;
	float dist = sqrt(pow(cord.x, 2) + pow(cord.y, 2));
	float w = sin(dist * 50 + frame / 10.0) * 0.5 + 0.5;

	w = w * wa * (1.0 - dist);

	float2 cord_w = input.TexCd * (1.0 - w) + 0.5 * w;
	
	float4 outCol = saturate(input.Col) * g_tex.Sample(g_sampler, cord_w);

	return outCol;
}
