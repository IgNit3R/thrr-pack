Texture2D t0: register(t0);
SamplerState s0 : register(s0);

Texture2D t1: register(t1);
SamplerState s1 : register(s1);

cbuffer ConstBuff : register(b0)
{
	float resolution_x;
	float resolution_y;
};

struct PS_INPUT
{
	float4 position : SV_POSITION;
	float4 color : COLOR;
	float2 texcord : TEXCOORD0;
};

float4 main(PS_INPUT input) : SV_Target
{
	float2 uv2;
	uv2.x = input.position.x / resolution_x;
	uv2.y = input.position.y / resolution_y;
	return t0.Sample(s0, input.texcord) * t1.Sample(s1, uv2) * input.color;
}
