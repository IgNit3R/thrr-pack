//背景　瘴気、湯気の揺らぎ
Texture2D g_tex: register(t0);
SamplerState g_sampler : register(s0);

//外部入力
cbuffer ConstBuff : register(b0)
{
	int frame;
	float wa;
};

struct PS_INPUT
{
	float4 Pos : SV_POSITION;
	float4 Col : COLOR;
	float2 TexCd : TEXCOORD0;
};

float4 main(PS_INPUT input) : SV_Target
{
	float2 outPos = input.TexCd;
/*	if(input.TexCd.y < 0.5){
		outPos.x = input.TexCd.x;
	}
	else{
		
	}*/
	outPos.x = input.TexCd.x + (0.075 - 0.075 * input.TexCd.y) * cos(input.TexCd.y * 10 + frame * 0.02);
	float4 outCol = g_tex.Sample(g_sampler, outPos) * input.Col;
	return outCol;
}
