Texture2D g_tex: register(t0);
SamplerState g_sampler : register(s0);

struct PS_INPUT
{
	float4 Pos : SV_POSITION;
	float4 Col : COLOR;
	float2 TexCd : TEXCOORD0;
};

float4 PS(PS_INPUT input) : SV_Target
{
	float4 outCol = saturate(input.Col) * g_tex.Sample(g_sampler, input.TexCd);

	if ((outCol.r + outCol.g + outCol.b) < 2.0)
	{
		outCol.r = 0.0;
		outCol.g = 0.0;
		outCol.b = 0.0;
	}
	outCol.a = 1.0;
	return outCol;
}
