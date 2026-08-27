Texture2D g_tex: register(t0);
SamplerState g_sampler : register(s0);

cbuffer ConstBuff : register(b0)
{
	float width;
	float height;
	float w0;
	float w1;
	float w2;
	float w3;
	float w4;
	float w5;
	float w6;
	float w7;
};

struct PS_INPUT
{
	float4 Pos : SV_POSITION;
	float4 Col : COLOR;
	float2 TexCd : TEXCOORD0;
};

float4 step1(PS_INPUT input) : SV_Target
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

float4 gauss_h(PS_INPUT input) : SV_Target
{
	float2 PixelSize = float2(1.0 / width, 1.0 / height);
	float4 col = float4(0, 0, 0, 0);

	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(-7, 0)) * w7;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(-6, 0)) * w6;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(-5, 0)) * w5;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(-4, 0)) * w4;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(-3, 0)) * w3;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(-2, 0)) * w2;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(-1, 0)) * w1;
	col += g_tex.Sample(g_sampler, input.TexCd) * w0 * 2.0;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(1, 0)) * w1;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(2, 0)) * w2;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(3, 0)) * w3;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(4, 0)) * w4;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(5, 0)) * w5;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(6, 0)) * w6;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(7, 0)) * w7;

	col.a = 1.0;

	return col;
}

float4 gauss_v(PS_INPUT input) : SV_Target
{
	float2 PixelSize = float2(1.0 / width, 1.0 / height);
	float4 col = float4(0, 0, 0, 0);

	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(0, -7)) * w7;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(0, -6)) * w6;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(0, -5)) * w5;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(0, -4)) * w4;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(0, -3)) * w3;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(0, -2)) * w2;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(0, -1)) * w1;
	col += g_tex.Sample(g_sampler, input.TexCd) * w0 * 2.0;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(0, 1)) * w1;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(0, 2)) * w2;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(0, 3)) * w3;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(0, 4)) * w4;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(0, 5)) * w5;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(0, 6)) * w6;
	col += g_tex.Sample(g_sampler, input.TexCd + PixelSize * float2(0, 7)) * w7;

	col.a = 1.0;

	return col;
}
