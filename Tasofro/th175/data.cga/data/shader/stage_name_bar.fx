Texture2D tex0: register(t0);
SamplerState s0 : register(s0);

static float resolution_x = 640.0;
static float resolution_y = 360.0;

cbuffer ConstBuff : register(b0)
{
	float threthold;
	float threthold2;
};

struct PS_INPUT
{
	float4 position : SV_POSITION;
	float4 color : COLOR;
	float2 texcord : TEXCOORD0;
};

float4 main(PS_INPUT input) : SV_Target
{
	float2 uv = input.texcord;
	if (uv.x > threthold || uv.x < threthold2 - 0.15)
	{
		discard;
	}

	if (uv.x >= threthold - 0.15)
	{
		float rate = (threthold - uv.x) / 0.15;
		uv.y = (uv.y - 0.25) / rate + 0.25;
	} else {
		if (uv.x < threthold2 && uv.x >= threthold2 - 0.15)
		{
			float rate = 1.0 - (threthold2 - uv.x) / 0.15;
			uv.y = (uv.y - 0.25) / rate + 0.25;
		}
	}
	
	if (uv.y > 1.0 || uv.y < 0.0)
	{
		discard;
	}

	float4 col = tex0.Sample(s0, uv) * input.color;
	
	return col;
}
