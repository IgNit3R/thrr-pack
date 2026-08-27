// 「勝利」文字に重ねるハイライト
Texture2D tex0: register(t0);
SamplerState s0 : register(s0);

Texture2D tex1: register(t1);
SamplerState s1 : register(s1);

cbuffer ConstBuff : register(b0)
{
	float slide_pos;
};

struct PS_INPUT
{
	float4 position : SV_POSITION;
	float4 color : COLOR;
	float2 texcord : TEXCOORD0;
};

float4 main(PS_INPUT input) : SV_Target
{
	float4 col0 = tex0.Sample(s0, input.texcord);
	float4 col1 = tex1.Sample(s1, input.texcord + float2(slide_pos, 0.0));

	col0.rgb += col1.rgb * col1.a;
/*
	if (col1.r != 0.0)
	{
		col0.rgb = 1 - (1 - col1.rgb) / col0.rgb + col0.rgb;
//		col0.rgb = 1 - (1 - col0.rgb) / col1.rgb;
	}
*/
	return col0;
}
