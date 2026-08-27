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
	float4 outCol = g_tex.Sample(g_sampler, input.TexCd) ;
	outCol.rgb *= (input.TexCd.y);

	return outCol * input.Col;
}
