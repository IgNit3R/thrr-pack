Texture2D tex0: register(t0);
SamplerState s0 : register(s0);

static float resolution_x = 640.0;
static float resolution_y = 360.0;

static float px_size = 1.0 / resolution_x;
static float py_size = 1.0 / resolution_y;

cbuffer ConstBuff : register(b0)
{
	float max_v;
};

struct PS_INPUT
{
	float4 position : SV_POSITION;
	float4 color : COLOR;
	float2 texcord : TEXCOORD0;
};

float4 main(PS_INPUT input) : SV_Target
{
	float4 r = tex0.Sample(s0, input.texcord + float2(px_size, 0));
	float4 l = tex0.Sample(s0, input.texcord + float2(-px_size, 0));
	float4 u = tex0.Sample(s0, input.texcord + float2(0, -py_size));
	float4 b = tex0.Sample(s0, input.texcord + float2(0, py_size));

	float4 out_col = tex0.Sample(s0, input.texcord);
	
	if (out_col.a < 0.7)
	{
		if (r.a > 0.7 || l.a > 0.7 || u.a > 0.7 || b.a > 0.7)
		{
			out_col = float4(0.9, 0.9, 0.9, 1);
			out_col.rgb *= saturate((/*1.0 - */input.texcord.y / max_v) * 0.25 + 0.75);
			return out_col;
		} else {
			discard;
		}
	}

	out_col.rgb *= saturate((1.0 - input.texcord.y / max_v) * 0.4 + 0.6);
	//out_col.g = 0.0;//(1.0 - input.texcord.y / max_v);
	//out_col.b = 0.0;//out_col.g;
	out_col.a = 1.0;
	
	if (l.a < 0.7 || u.a < 0.7)
	{
		out_col.rgb *= 0.65;
	}
	
	out_col *= input.color;
	
	return out_col;
}
