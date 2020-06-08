const consts = {
	// TODO: DNA length is hard-coded into regex.
	dnaPattern: /[0-9]{6}/,
	
	dnaLength: 6,
	dnaHatPos: 0,
	dnaHeadPos: 1,
	dnaEyesPos: 2,
	dnaBodyPos: 3,
	dnaShieldPos: 4,
	dnaWeaponPos: 5,
	assetCategoryHats: "hats",
	assetCategoryHeads: "heads",
	assetCategoryEyes: "eyes",
	assetCategoryBody: "body",
	assetCategoryShields: "shields",
	assetCategoryWeapons: "weapons",
	randomHatsMax: 6,
	randomHeadsMax: 7,
	randomEyesMax: 6,
	randomBodyMax: 0,
	randomShieldsMax: 0,
	randomWeaponMax: 0
};

let $document = $(document);
let $dna;
let $generate;
let $random;
let $copyHero;
let $heroWrap;
let $heroHat;
let $heroHead;
let $heroEyes;
let $heroBody;
let $heroShield;
let $heroWeapon;

$document.ready(function() {
	// Assign hero parts elements.
	$heroHat = $("#hero-hat");
	$heroHead = $("#hero-head");
	$heroEyes = $("#hero-eyes");
	$heroBody = $("#hero-body");
	$heroShield = $("#hero-shield");
	$heroWeapon = $("#hero-weapon");
	
	// Assign UI elements.
	$heroWrap = $("#hero-wrap");
	$dna = $("#dna");
	$generate = $("#generate");
	$random = $("#random");
	$copyHero = $("#copy-hero");
	
	// Configure the DNA input and set its max length.
	$dna.attr("maxlength", consts.dnaLength);
	
	// Initially focus the DNA input.
	$dna.focus();
	
	$generate.click(function() {
		const dnaString = $dna.val();
		
		loadHeroFromDnaString(dnaString);
	});

	$dna.keypress(function(e) {
		if (e.which === 13) {
			$generate.trigger("click");
		}
	});

	$random.click(function() {
		const heroDna = generateRandomHeroDna();
		
		loadHero(heroDna);
	});
	
	$copyHero.click(function() {
		const heroDna = $dna.val();
		
		if (verifyHeroDnaString(heroDna)) {
			window.location.hash = heroDna;
			
			navigator.clipboard.writeText(window.location).then(function() {
				alert("The URL for this hero has been copied to your clipboard!");
			});
		}
	});
	
	// Check and apply provided hero DNA from window location hash.
	if (window.location.hash !== "") {
		const heroDna = window.location.hash.substr(1);
		
		if (verifyHeroDnaString(heroDna)) {
			alert("Window location hash contains an invalid hero DNA, and has been ignored.");
			
			return;
		}
		
		$dna.val(heroDna);
		$generate.trigger("click");
	}
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
	loadAsset(consts.assetCategoryBody, hero.body, $heroBody);
	loadAsset(consts.assetCategoryShields, hero.shield, $heroShield);
	//loadAsset(consts.assetCategoryWeapons, hero.weapon, $heroWeapon);
	$heroWrap.css("background", `radial-gradient(#222, rgba(${hero.background.r}, ${hero.background.g}, ${hero.background.b}, 0.4)`);
	$dna.val(assembleHeroDna(hero));
	$dna.focus();
	console.log("Hero loaded", hero);
}

function loadHeroFromDnaString(heroDnaString) {
	if (heroDnaString.length != consts.dnaLength) {
		alert(`DNA must be ${consts.dnaLength} character(s) long`);
		
		return;
	}
	
	try {
		loadHero({
			hat: getIntAt(heroDnaString, consts.dnaHatPos),
			head: getIntAt(heroDnaString, consts.dnaHeadPos),
			eyes: getIntAt(heroDnaString, consts.dnaEyesPos),
			body: getIntAt(heroDnaString, consts.dnaBodyPos),
			shield: getIntAt(heroDnaString, consts.dnaShieldPos),
			weapon: getIntAt(heroDnaString, consts.dnaWeaponPos),
			
			// TODO: Should be loaded from DNA.
			background: getRandomRgbColor()
		});
	}
	catch (error) {
		alert("Failed to parse hero DNA: " + error.message);
		
		// Focus on the DNA input after generating the character.
		$dna.focus();
	}
}

function randomInt(min, max) {
  return Math.floor(Math.random() * (max - min + 1) + min);
}

function generateRandomHeroDna() {
	return {
		hat: randomInt(0, consts.randomHatsMax),
		head: randomInt(0, consts.randomHeadsMax),
		eyes: randomInt(0, consts.randomEyesMax),
		body: randomInt(0, consts.randomBodyMax),
		shield: randomInt(0, consts.randomShieldsMax),
		weapon: randomInt(0, consts.randomWeaponsMax),
		background: getRandomRgbColor()
	};
}

function verifyHeroDnaStringString(heroDnaString) {
	return typeof heroDnaString === "string"
		&& heroDnaString.length === consts.dnaLength
		&& consts.dnaPattern.test(heroDnaString);
}

function assembleHeroDna(heroDna) {
	return heroDna.hat.toString()
		+ heroDna.head.toString()
		+ heroDna.eyes.toString()
		+ heroDna.body.toString()
		+ heroDna.shield.toString()
		+ heroDna.weapon.toString();
}

function getRandomHexColor() {
	return Math.floor(Math.random()*16777215).toString(16);
}

function getRandomRgbColor() {
  let num = Math.round(0xffffff * Math.random());
  
  return {
	  r: num >> 16,
	  g: num >> 8 & 255,
	  b: num & 255
  };
}