Texture2D g_tex: register(t0);
SamplerState g_sampler : register(s0);

cbuffer ConstBuff : register(b0)
{
	float width;
	float height;
	float dx;
	float dy;
};

struct PS_INPUT
{
	float4 Pos : SV_POSITION;
	float4 Col : COLOR;
	float2 TexCd : TEXCOORD0;
};

float4 PS(PS_INPUT input) : SV_Target
{
	float4 c = g_tex.Sample(g_sampler, input.TexCd);

	float4 arround = float4(0, 0, 0, 0);
	arround += g_tex.Sample(g_sampler, input.TexCd + float2( dx,  dy)) - 0.5;
	arround += g_tex.Sample(g_sampler, input.TexCd + float2( dx,   0)) - 0.5;
	arround += g_tex.Sample(g_sampler, input.TexCd + float2( dx, -dy)) - 0.5;

	arround += g_tex.Sample(g_sampler, input.TexCd + float2(-dx,  dy)) - 0.5;
	arround += g_tex.Sample(g_sampler, input.TexCd + float2(-dx,   0)) - 0.5;
	arround += g_tex.Sample(g_sampler, input.TexCd + float2(-dx, -dy)) - 0.5;

	arround += g_tex.Sample(g_sampler, input.TexCd + float2(  0,  dy)) - 0.5;
	arround += g_tex.Sample(g_sampler, input.TexCd + float2(  0, -dy)) - 0.5;

	arround /= 4.0;

	float4 dst = (arround - (c - 0.5));
	dst += 0.5;
/*
	if (dst.r > 1.0)
	{
		dst.r = 1.0;
		dst.g = 1.0;
		dst.b = 1.0;
	}

	if (dst.r < 0.0)
	{
		dst.r = 0.0;
		dst.g = 0.0;
		dst.b = 0.0;
	}
*/
	dst.a = 1.0;

	return dst;

/*
//	float4 pow_y1 = g_tex.Sample(g_sampler, input.TexCd + float2(0,  dy)) - col;
//	float4 pow_y2 = g_tex.Sample(g_sampler, input.TexCd + float2(0, -dy)) - col;

	float4 col = (r + l - 2.0 * c) * 0.7;
//	col += (pow_x1 + pow_x2 + pow_y1 + pow_y2) * 0.9;
//	col += g_tex.Sample(g_sampler, input.TexCd + float2(0,  dy)) * 1.0;
//	col += g_tex.Sample(g_sampler, input.TexCd + float2(0, -dy)) * 1.0;

//	col /= 4.0;
	col.a = 1.0;

	return col;
*/
}
