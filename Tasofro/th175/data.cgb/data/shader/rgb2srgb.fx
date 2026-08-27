Texture2D tex0: register(t0);
SamplerState sampler0 : register(s0);

Texture2D tex1: register(t1);
SamplerState sampler1 : register(s1);

cbuffer ConstantBuffer : register(b0)
{
}

struct PS_INPUT
{
	float4 position : SV_POSITION;
	float4 color : COLOR;
	float2 texcord : TEXCOORD0;
};

float4 main(PS_INPUT input) : SV_Target
{
	float4 col = tex0.Sample(sampler0, input.texcord) * input.color;

	if (col.r <= 0.04045)
	{
		col.r /= 12.92;
	} else {
		col.r = pow((col.r + 0.055) / 1.055, 2.4);
	}

	if (col.g <= 0.04045)
	{
		col.g /= 12.92;
	} else {
		col.g = pow((col.g + 0.055) / 1.055, 2.4);
	}

	if (col.b <= 0.04045)
	{
		col.b /= 12.92;
	} else {
		col.b = pow((col.b + 0.055) / 1.055, 2.4);
	}

/*
	if (col.r <= 0.0031308)
	{
		col.r *= 12.92;
	} else {
		col.r = pow(col.r, 1.0 / 2.4) * 1.055 - 0.055;
	}

	if (col.g <= 0.0031308)
	{
		col.g *= 12.92;
	} else {
		col.g = pow(col.g, 1.0 / 2.4) * 1.055 - 0.055;
	}

	if (col.b <= 0.0031308)
	{
		col.b *= 12.92;
	} else {
		col.b = pow(col.b, 1.0 / 2.4) * 1.055 - 0.055;
	}
*/
	return col;
}
