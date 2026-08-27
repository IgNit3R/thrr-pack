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

float4 get_pixel(float2 _center_uv, float _dx, float _dy)
{
	float2 pixel_norm = float2(1.0 / width, 1.0 / height);

	float2 pickup_uv = _center_uv + pixel_norm * float2(_dx, _dy);
	if (pickup_uv.x >= 0.5 || pickup_uv.y >= 0.5) return float4(0.0, 0.0, 0.0, 1.0);
	
	return g_tex.Sample(g_sampler, pickup_uv);
}

float4 main(PS_INPUT input) : SV_Target
{
	float2 PixelSize = float2(1.0 / width, 1.0 / height);
	float4 col = float4(0, 0, 0, 0);

	col += get_pixel(input.TexCd, 0, -7) * w7;
	col += get_pixel(input.TexCd, 0, -6) * w6;
	col += get_pixel(input.TexCd, 0, -5) * w5;
	col += get_pixel(input.TexCd, 0, -4) * w4;
	col += get_pixel(input.TexCd, 0, -3) * w3;
	col += get_pixel(input.TexCd, 0, -2) * w2;
	col += get_pixel(input.TexCd, 0, -1) * w1;
	col += get_pixel(input.TexCd, 0, 0) * w0 * 2.0;
	col += get_pixel(input.TexCd, 0, 1) * w1;
	col += get_pixel(input.TexCd, 0, 2) * w2;
	col += get_pixel(input.TexCd, 0, 3) * w3;
	col += get_pixel(input.TexCd, 0, 4) * w4;
	col += get_pixel(input.TexCd, 0, 5) * w5;
	col += get_pixel(input.TexCd, 0, 6) * w6;
	col += get_pixel(input.TexCd, 0, 7) * w7;

	col.a = 1.0;

	return col;
}
