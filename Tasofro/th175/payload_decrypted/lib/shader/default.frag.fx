Texture2D tex0: register(t0);
SamplerState sampler0 : register(s0);

struct PS_INPUT
{
	float4 position : SV_POSITION;
	float4 color : COLOR;
	float2 texcord : TEXCOORD0;
};

float4 main(PS_INPUT input) : SV_Target
{
	return tex0.Sample(sampler0, input.texcord) * input.color;
}
