Texture2D g_tex: register(t0);
SamplerState g_sampler : register(s0);

struct PS_INPUT
{
	float4 Pos : SV_POSITION;
	float4 Col : COLOR;
	float2 TexCd : TEXCOORD0;
};

float4 get_pixel(float2 _center_uv, float _dx, float _dy)
{
	float2 pixel_norm = float2(1.0 / 640.0, 1.0 / 360.0);

	float4 col = g_tex.Sample(g_sampler, _center_uv + pixel_norm * float2(_dx, _dy));

	if ((col.r + col.g + col.b) < 2.0)
	{
		col.r = 0.0;
		col.g = 0.0;
		col.b = 0.0;
	}
	col.a = 1.0;

	return col;
}

float4 main_hd(PS_INPUT input) : SV_Target		// for 1280x720
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


float4 main(PS_INPUT input) : SV_Target		// for 640x360
{
	float2 PixelSize = float2(1.0 / 640.0, 1.0 / 360.0);
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
/*
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
*/

	col += get_pixel(input.TexCd, -7, 0) * 0.00177500420;
	col += get_pixel(input.TexCd, -6, 0) * 0.00544012850;
	col += get_pixel(input.TexCd, -5, 0) * 0.0142079657;
	col += get_pixel(input.TexCd, -4, 0) * 0.0316204131;
	col += get_pixel(input.TexCd, -3, 0) * 0.0599675067;
	col += get_pixel(input.TexCd, -2, 0) * 0.0969119519;
	col += get_pixel(input.TexCd, -1, 0) * 0.133460134;
	col += get_pixel(input.TexCd, 0, 0) * 0.313233852;
	col += get_pixel(input.TexCd, 1, 0) * 0.133460134;
	col += get_pixel(input.TexCd, 2, 0) * 0.0969119519;
	col += get_pixel(input.TexCd, 3, 0) * 0.0599675067;
	col += get_pixel(input.TexCd, 4, 0) * 0.0316204131;
	col += get_pixel(input.TexCd, 5, 0) * 0.0142079657;
	col += get_pixel(input.TexCd, 6, 0) * 0.00544012850;
	col += get_pixel(input.TexCd, 7, 0) * 0.00177500420;



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
