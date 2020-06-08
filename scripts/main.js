const constants = {
	dnaLength: 2,
	dnaHeadPos: 0,
	dnaEyesPos: 1,
	assetCategoryHeads: "heads",
	assetCategoryEyes: "eyes"
};

$(document).ready(function() {
	const $heroHead = $("#hero-head");
	const $heroEyes = $("#hero-eyes");
	const $dna = $("#dna");
	
	$("#generate").click(function() {
		const dnaString = $dna.val();
		
		if (dnaString.length != constants.dnaLength) {
			alert(`DNA must be ${constants.dnaLength} character(s) long`);
			
			return;
		}
		
		try {
			const headIndex = getIntAt(dnaString, constants.dnaHeadPos);
			const eyesIndex = getIntAt(dnaString, constants.dnaEyesPos);
			
			loadAsset(constants.assetCategoryHeads, headIndex, $heroHead);
			loadAsset(constants.assetCategoryEyes, eyesIndex, $heroEyes);
		}
		catch (error) {
			alert("Failed to parse DNA: " + error.message);
		}
		
		// Focus on the DNA input after generating the character.
		$dna.focus();
	});
});

function getIntAt(string, index) {
	return parseInt(string[index]);
}

function loadAsset(category, index, $image) {
	$image.attr("src", `assets/hero/${category}/${index}/${index}.png`);
}