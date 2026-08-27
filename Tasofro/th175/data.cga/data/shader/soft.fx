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
	float2 PixelSize = float2(1.0 / 320.0, 1.0 / 180.0);
	float4 col = float4(0, 0, 0, 0);

//	float2 cord = input.TexCd  + PixelSize * float2(20, 100);
//	col += g_tex.Sample(g_sampler, cord);

/*
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(-3, 0)) * 0.053;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(-2, 0)) * 0.123;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(-1, 0)) * 0.203;
	col += g_tex.Sample(g_sampler, input.TexCd) * 0.240;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(1, 0)) * 0.203;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(2, 0)) * 0.123;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(3, 0)) * 0.053;
*/
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(-7, 0)) * 0.00177500420;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(-6, 0)) * 0.00544012850;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(-5, 0)) * 0.0142079657;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(-4, 0)) * 0.0316204131;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(-3, 0)) * 0.0599675067;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(-2, 0)) * 0.0969119519;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(-1, 0)) * 0.133460134;
	col += g_tex.Sample(g_sampler, input.TexCd) * 0.313233852;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(1, 0)) * 0.133460134;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(2, 0)) * 0.0969119519;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(3, 0)) * 0.0599675067;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(4, 0)) * 0.0316204131;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(5, 0)) * 0.0142079657;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(6, 0)) * 0.00544012850;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(7, 0)) * 0.00177500420;

	col.a = input.Col.a;

	return col;
/*
	float4 outCol = saturate(input.Col) * g_tex.Sample(g_sampler, input.TexCd);

	if ((outCol.r + outCol.g + outCol.b) < 2.0)
	{
		outCol.r = 0.0;
		outCol.g = 0.0;
		outCol.b = 0.0;
	}
	outCol.a = 1.0;
	return outCol;
*/
}
