//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float invertAmount;

uniform bool  globalOverride;
uniform vec4  globalSepiaColor;
uniform float globalBloomMultiply;

uniform bool  tintEnable;
uniform vec4  sepiaColor;
uniform float bloomMultiply;

uniform float critShaderAmount;

uniform float shieldShaderAmount;
uniform float shieldShaderFlashPercent;

uniform vec4 solidColor;


void main()
{
	#region Get the initial texture sample of the sprite.
	vec4 texSample = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	#endregion
		
	#region Color Invert Modifier
	vec3 texInvert = mix(texSample.rgb, vec3(1.0) - texSample.rgb, invertAmount);
	#endregion
	
	#region Global Color Modifiers
	
	vec3 lum = vec3(0.299, 0.587, 0.114);
	float bw = dot( texInvert.rgb, lum);
	
	vec3 globalColorFinal = texInvert.rgb;
	
	//if ( globalOverride == false )
	//{ 
		
		#region Global Sepia
		//vec3 gSepiaMix = bw * globalSepiaColor.rgb;
		//vec3 texGlobalSepia = mix(globalColorFinal.rgb, gSepiaMix.rgb, globalSepiaColor.a);
		#endregion
		
		
		
		#region Global Bloom
		//vec3 texGlobalBloom = texGlobalSepia.rgb * vec3(globalBloomMultiply);
		#endregion
		
		
		//globalColorFinal = texGlobalSepia.rgb;
		//globalColorFinal = texInvert.rgb;
		
	//}
	
	
	#endregion
	
	#region Local Color Modifiers
	
	vec3 localColorFinal = globalColorFinal;
	
	if ( tintEnable )
	{
		#region Sepia
		bw = dot( globalColorFinal.rgb, lum);
		vec3 sepiaMix = bw * sepiaColor.rgb;
		vec3 texSepia = mix(globalColorFinal.rgb, sepiaMix.rgb, sepiaColor.a);
		#endregion
	
		#region Bloom
		vec3 texBloom = texSepia.rgb * vec3(bloomMultiply);
		#endregion
		
		localColorFinal = texBloom;
	}
	
	#endregion
	
	#region Crit Color Shade
		
	vec3 colorize= vec3(0.0);
	if ( bw > 0.33 ) { colorize = mix( vec3(0.10, 0.60, 0.20), vec3(1.0), ( bw - 0.33 ) / 0.67); } else { colorize = mix( vec3(0.50, 0.70, 0.20), vec3(0.10, 0.60, 0.20), bw / 0.33); } //vec3(0.22, 0.33, 0.49)  //vec3(0.075, 0.085, 0.12) //vec3(0.299, 0.587, 0.114);
	
	vec3 texCrit = mix(localColorFinal.rgb, colorize.rgb, critShaderAmount );
	if ( critShaderAmount > 0.0 ) { texCrit.rgb += vec3(bw) * 0.25 * critShaderAmount; }
	
	localColorFinal = texCrit;
	
	#endregion
	
	#region Shield Color Shade
	
	if ( shieldShaderAmount > 0.0 )
	{
		vec3 shieldBlendCol = vec3( 1.0, 0.0, 0.0 );
	
		vec3 colorize = mix(vec3(0.0), shieldBlendCol, bw / shieldShaderFlashPercent);
		if ( bw > shieldShaderFlashPercent ) { colorize = mix( shieldBlendCol, vec3(1.0), ( bw - shieldShaderFlashPercent ) / (1.0 - shieldShaderFlashPercent) ); }
		
		vec3 texShield = localColorFinal.rgb + ( colorize.rgb * shieldShaderAmount );
	
		localColorFinal = texShield;
	}
	
	#endregion
	
	#region Solid Color Flash
	vec3 texSolid = mix(localColorFinal.rgb, solidColor.rgb, clamp(solidColor.a, 0.0, 1.0));
	gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	gl_FragColor.rgb = texSolid.rgb;
	#endregion
}