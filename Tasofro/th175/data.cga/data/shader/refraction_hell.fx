/**
 * 灼熱地獄 背景用屈折シェーダー
 */
Texture2D tex0: register(t0);
SamplerState s0 : register(s0);

Texture2D tex1: register(t1);
SamplerState s1 : register(s1);

Texture2D tex2: register(t2);
SamplerState s2 : register(s2);

cbuffer ConstBuff : register(b0)
{
	float u_offset;
	float v_offset;
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
	float px_size = 1.0 / 640.0;
	float py_size = 1.0 / 360.0;

	float2 src_uv = input.texcord;
	src_uv.x = (src_uv.x + u_offset) % 1.0;
	src_uv.y = (src_uv.y + v_offset) % 1.0;

	float4 r = tex1.Sample(s1, src_uv + float2(px_size, 0));
	float4 l = tex1.Sample(s1, src_uv + float2(-px_size, 0));
	float4 u = tex1.Sample(s1, src_uv + float2(0, -py_size));
	float4 b = tex1.Sample(s1, src_uv + float2(0, py_size));
	
	float4 pow = tex2.Sample(s2, input.texcord);

	offset = float2(r.r - l.r, u.r - b.r);
	offset *= px_size * 200.0 * (pow.r * 0.6 + 0.15);//30.0;

	float4 col = tex0.Sample(s0, input.texcord + offset) * input.color;
//	col.a = 1.0;

	return col;
}
