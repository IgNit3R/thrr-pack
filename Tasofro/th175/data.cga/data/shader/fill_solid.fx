// ’¸“_ƒJƒ‰[‚Å“h‚è‚Â‚Ô‚·
Texture2D tex0: register(t0);
SamplerState s0 : register(s0);

struct PS_INPUT
{
	float4 position : SV_POSITION;
	float4 color : COLOR;
	float2 texcord : TEXCOORD0;
};

float4 main(PS_INPUT input) : SV_Target
{
	float4 out_col = tex0.Sample(s0, input.texcord);

	if (out_col.a < 0.7)
	{
		discard;
	}

	out_col.rgb = input.color.rgb;
	out_col.a = 1.0;

	return out_col;
}
