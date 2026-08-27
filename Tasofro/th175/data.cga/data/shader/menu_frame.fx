Texture2D tex0: register(t0);
SamplerState s0 : register(s0);

Texture2D tex1: register(t1);
SamplerState s1 : register(s1);

struct PS_INPUT
{
	float4 position : SV_POSITION;
	float4 color : COLOR;
	float2 texcord : TEXCOORD0;
};

float4 menu_outer_circle(PS_INPUT input) : SV_Target
{
	input.texcord.x -= 0.05;
	float2 cord_n = input.texcord * 2.0 - 1.0;
	float dist = sqrt(pow(cord_n.x, 2) + pow(cord_n.y, 2));
	
	float2 pick_uv = 0;
	float4 col = float4(0, 0, 0, 0);
	if (dist < 1.0 || input.texcord.x >= 0.5)
	{
		discard;
	} else {
/*
		if (dist > 1.4)
		{
			discard;
		}
*/
		float angle = atan2(cord_n.y, cord_n.x);
		pick_uv.x = abs(angle) / 3.1415926535;
		pick_uv.y = 1.0 - (dist - 1.0) / 0.4;
		
//		pick_uv = input.texcord;
		
//		return float4(1,0,1,1);
		col = tex1.Sample(s1, pick_uv) * input.color;
		col.r += (1.0 - pick_uv.y) * 0.6;
		col.r -= (pick_uv.y) * 0.35;
	}

	if (col.r < 0.2)
	{
		return float4(0, 0, 0, 1);
	} else {
		return float4(1, 1, 1, 0) * input.color;
	}

	return col;


/*
	float2 cord_n = input.texcord * 2.0 - 1.0;
	float dist = sqrt(pow(cord_n.x, 2) + pow(cord_n.y, 2));
	
	if (dist < 1.0)
	{
		return float4(0, 0, 0, 1);
	} else {
		return float4(1, 1, 1, 1) * input.color;
	}
*/
}


float4 menu_innder_circle(PS_INPUT input) : SV_Target
{
	float2 cord_n = float2(1.85 - input.texcord.x - 0.2, 1.85 - input.texcord.y - 0.33);
	float dist = sqrt(pow(cord_n.x, 2) + pow(cord_n.y, 2));

	if (dist < 1.8)
	{
		discard;
	}

	// refraction
	float2 offset = float2(0, 0);
	float px_size = 1.0 / 256.0;

	float4 r = tex1.Sample(s1, input.texcord + float2(px_size, 0));
	float4 l = tex1.Sample(s1, input.texcord + float2(-px_size, 0));
	float4 u = tex1.Sample(s1, input.texcord + float2(0, -px_size));
	float4 b = tex1.Sample(s1, input.texcord + float2(0, px_size));
	
	offset = float2(r.r - l.r, u.r - b.r);
	offset *= px_size * 100.0;

	float4 col = tex0.Sample(s0, input.texcord + offset) * input.color;
//	col.a = 1.0;

	return col;
}

