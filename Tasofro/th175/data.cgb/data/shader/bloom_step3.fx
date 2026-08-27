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
	float2 PixelSize = float2(1.0 / 640.0, 1.0 / 360.0);
	float4 col = float4(0, 0, 0, 0);

	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(0, -7)) * 0.00177500420;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(0, -6)) * 0.00544012850;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(0, -5)) * 0.0142079657;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(0, -4)) * 0.0316204131;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(0, -3)) * 0.0599675067;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(0, -2)) * 0.0969119519;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(0, -1)) * 0.133460134;
	col += g_tex.Sample(g_sampler, input.TexCd) * 0.313233852;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(0, 1)) * 0.133460134;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(0, 2)) * 0.0969119519;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(0, 3)) * 0.0599675067;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(0, 4)) * 0.0316204131;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(0, 5)) * 0.0142079657;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(0, 6)) * 0.00544012850;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(0, 7)) * 0.00177500420;
/*
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(0, -3)) * 0.053;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(0, -2)) * 0.123;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(0, -1)) * 0.203;
	col += g_tex.Sample(g_sampler, input.TexCd) * 0.240;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(0, 1)) * 0.203;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(0, 2)) * 0.123;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(0, 3)) * 0.053;
*/
	col.a = 1.0;

	return col;
}
