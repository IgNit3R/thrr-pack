Texture2D tex0: register(t0);
SamplerState s0 : register(s0);

cbuffer ConstBuff : register(b0)
{
	float wave_offset;
	float power;
};

struct PS_INPUT
{
	float4 position : SV_POSITION;
	float4 color : COLOR;
	float2 texcord : TEXCOORD0;
};

float4 main(PS_INPUT input) : SV_Target
{
//	float y = input.texcord.y + wave_offset;
	float x = input.texcord.y - (1.0 - input.texcord.x);// - fade_x;
	float wave_i = (wave_offset - input.texcord.x);
	x += sin(wave_i * 360 * 15 * 3.1415926535 / 180.0) * 0.010 * power;
	x += sin((wave_i + wave_offset * 2) * 360 * 10 * 3.1415926535 / 180.0) * 0.015 * power;
	x += sin((wave_i - wave_offset * 3) * 360 * 7 * 3.1415926535 / 180.0) * 0.025 * power;
	x += sin((wave_i + wave_offset * 4) * 360 * 3 * 3.1415926535 / 180.0) * 0.05 * power;
	if (x < 0.0)
	{
		discard;
	}

	return float4(0, 0, 0, input.color.a);
//	float4 col = tex0.Sample(s0, input.texcord) * input.color;

//	return col;
}

