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
	float4 col = tex1.Sample(sampler1, input.texcord) * input.color;
	col.g *= 0.0;
	col.b *= 0.0;
//	float4 col = tex1.Sample(sampler1, input.texcord) * input.color;
	return col;
}
