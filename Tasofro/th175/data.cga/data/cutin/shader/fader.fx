Texture2D tex0: register(t0);
SamplerState s0 : register(s0);

cbuffer ConstBuff : register(b0)
{
	float wave_offset;
	float fade_x;
};

struct PS_INPUT
{
	float4 position : SV_POSITION;
	float4 color : COLOR;
	float2 texcord : TEXCOORD0;
};

float4 main(PS_INPUT input) : SV_Target
{
	float y = input.texcord.y + wave_offset;
	float x = input.texcord.x - fade_x;
	x += sin(y * 360 * 15 * 3.1415926535 / 180.0) * 0.015;
	x += sin(y * 360 * 10 * 3.1415926535 / 180.0) * 0.025;
	x += sin(y * 360 * 7 * 3.1415926535 / 180.0) * 0.035;
	x += sin(y * 360 * 3 * 3.1415926535 / 180.0) * 0.020;
	if (x < 0.0)
	{
		discard;
	}

	float4 col = tex0.Sample(s0, input.texcord) * input.color;

	return col;
}

