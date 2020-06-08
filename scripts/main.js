const consts = {
	dnaLength: 3,
	dnaHatPos: 0,
	dnaHeadPos: 1,
	dnaEyesPos: 2,
	assetCategoryHats: "hats",
	assetCategoryHeads: "heads",
	assetCategoryEyes: "eyes",
	randomHatsMax: 3,
	randomHeadsMax: 1,
	randomEyesMax: 6
};

let $heroHat;
let $heroHead;
let $heroEyes;

$(document).ready(function() {
	$heroHat = $("#hero-hat");
	$heroHead = $("#hero-head");
	$heroEyes = $("#hero-eyes");
	
	const $dna = $("#dna");
	const $generate = $("#generate");
	const $random = $("#random");
	
	$generate.click(function() {
		const dnaString = $dna.val();
		
		if (dnaString.length != consts.dnaLength) {
			alert(`DNA must be ${consts.dnaLength} character(s) long`);
			
			return;
		}
		
		try {
			loadHero({
				hat: getIntAt(dnaString, consts.dnaHatPos),
				head: getIntAt(dnaString, consts.dnaHeadPos),
				eyes: getIntAt(dnaString, consts.dnaEyesPos)
			});
		}
		catch (error) {
			alert("Failed to parse DNA: " + error.message);
		}
		
		// Focus on the DNA input after generating the character.
		$dna.focus();
	});

	$dna.keypress(function(e) {
		if (e.which == 13) {
			$generate.trigger("click");
		}
	});

	$random.click(function() {
		loadHero({
			hat: randomInt(0, consts.randomHatsMax),
			head: randomInt(0, consts.randomHeadsMax),
			eyes: randomInt(0, consts.randomEyesMax)
		});
	});
});

function getIntAt(string, index) {
	return parseInt(string[index]);
}

function loadAsset(category, index, $image) {
	$image.attr("src", `assets/hero/${category}/${index}/${index}.png`);
}

function loadHero(hero) {
	loadAsset(consts.assetCategoryHats, hero.hat, $heroHat);
	loadAsset(consts.assetCategoryHeads, hero.head, $heroHead);
	loadAsset(consts.assetCategoryEyes, hero.eyes, $heroEyes);
	console.log("Hero loaded", hero);
}

function randomInt(min, max) {
  return Math.floor(Math.random() * (max - min + 1) + min);
}