//Texture2D tex0: register(t0);
//SamplerState s0 : register(s0);

struct PS_INPUT
{
	float4 position : SV_POSITION;
	float4 color : COLOR;
//	float2 texcord : TEXCOORD0;
};

float4 main(PS_INPUT input) : SV_Target
{
	return input.color;
}
