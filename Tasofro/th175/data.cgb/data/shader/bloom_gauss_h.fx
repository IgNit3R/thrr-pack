Texture2D g_tex: register(t0);
SamplerState g_sampler : register(s0);

cbuffer ConstBuff : register(b0)
{
	float width;
	float height;
	float bright_threshold;
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

float4 get_pixel(float2 _center_uv, float _dx, float _dy)
{
	float2 pixel_norm = float2(1.0 / width, 1.0 / height);

	float2 pickup_uv = _center_uv + pixel_norm * float2(_dx, _dy);
//	if (pickup_uv.x >= 0.5 || pickup_uv.y >= 0.5) return float4(0.0, 0.0, 0.0, 1.0);
	
	float4 col = g_tex.Sample(g_sampler, pickup_uv);

	if ((col.r + col.g + col.b) < bright_threshold)
	{
		col.r = 0.0;
		col.g = 0.0;
		col.b = 0.0;
	}
	col.a = 1.0;

	return col;
}

float4 main(PS_INPUT input) : SV_Target
{
//	float2 PixelSize = float2(1.0 / width, 1.0 / height);
	float4 col = float4(0, 0, 0, 0);

	col += get_pixel(input.TexCd, -7, 0) * w7;
	col += get_pixel(input.TexCd, -6, 0) * w6;
	col += get_pixel(input.TexCd, -5, 0) * w5;
	col += get_pixel(input.TexCd, -4, 0) * w4;
	col += get_pixel(input.TexCd, -3, 0) * w3;
	col += get_pixel(input.TexCd, -2, 0) * w2;
	col += get_pixel(input.TexCd, -1, 0) * w1;
	col += get_pixel(input.TexCd, 0, 0) * w0 * 2.0;
	col += get_pixel(input.TexCd, 1, 0) * w1;
	col += get_pixel(input.TexCd, 2, 0) * w2;
	col += get_pixel(input.TexCd, 3, 0) * w3;
	col += get_pixel(input.TexCd, 4, 0) * w4;
	col += get_pixel(input.TexCd, 5, 0) * w5;
	col += get_pixel(input.TexCd, 6, 0) * w6;
	col += get_pixel(input.TexCd, 7, 0) * w7;
/*
	col += get_pixel(-7, 0)) * w7;
	col += get_pixel(-6, 0)) * w6;
	col += get_pixel(-5, 0)) * w5;
	col += get_pixel(-4, 0)) * w4;
	col += get_pixel(-3, 0)) * w3;
	col += get_pixel(-2, 0)) * w2;
	col += get_pixel(-1, 0)) * w1;
	col += g_tex.Sample(g_sampler, input.TexCd) * w0 * 2.0;
	col += get_pixel(1, 0)) * w1;
	col += get_pixel(2, 0)) * w2;
	col += get_pixel(3, 0)) * w3;
	col += get_pixel(4, 0)) * w4;
	col += get_pixel(5, 0)) * w5;
	col += get_pixel(6, 0)) * w6;
	col += get_pixel(7, 0)) * w7;
*/
	col.a = 1.0;

	return col;
}
