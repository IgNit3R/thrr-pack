Texture2D tex0: register(t0);
SamplerState s0 : register(s0);

Texture2D tex1: register(t1);
SamplerState s1 : register(s1);

cbuffer ConstBuff : register(b0)
{
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
	float2 offset = float2(0, 0);
	float px_size = 1.0 / 256.0;
	float py_size = 1.0 / 256.0;

	float4 r = tex1.Sample(s1, input.texcord + float2(px_size, 0));
	float4 l = tex1.Sample(s1, input.texcord + float2(-px_size, 0));
	float4 u = tex1.Sample(s1, input.texcord + float2(0, -py_size));
	float4 b = tex1.Sample(s1, input.texcord + float2(0, py_size));
	
//	offset = float2(abs(r.r - l.r), u.r - b.r);
	offset = float2(r.r - l.r, u.r - b.r);
	offset *= px_size * power * 1.5;

	float4 col = tex0.Sample(s0, input.texcord + offset) * input.color;
	col.a *= 1.0 - power / 200.0;
//	col.a = 1.0;

	return col;
}
