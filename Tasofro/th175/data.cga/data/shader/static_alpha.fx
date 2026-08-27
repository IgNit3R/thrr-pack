Texture2D tex0: register(t0);
SamplerState s0 : register(s0);

cbuffer ConstBuff : register(b0)
{
	float alpha;
};

struct PS_INPUT
{
	float4 position : SV_POSITION;
	float4 color : COLOR;
	float2 texcord : TEXCOORD0;
};

float4 main(PS_INPUT input) : SV_Target
{
	float4 out_col = tex0.Sample(s0, input.texcord) * input.color;
	out_col.a = alpha;

	return out_col;
}
