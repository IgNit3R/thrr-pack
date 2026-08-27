Texture2D g_tex: register(t0);
SamplerState g_sampler : register(s0);

struct PS_INPUT
{
	float4 Pos : SV_POSITION;
	float4 Col : COLOR;
	float2 TexCd : TEXCOORD0;
};

float4 main(PS_INPUT input) : SV_Target
{
	float4 outCol = g_tex.Sample(g_sampler, input.TexCd) ;
	outCol.r = 1.0;
	outCol.g = 1.0;
	outCol.b = 1.0;
//	outCol.a = 0.0;

	return outCol * input.Col;
}
