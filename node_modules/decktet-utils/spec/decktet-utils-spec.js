describe("DecktetUtils", function() {

  it("should find cards by name", function() {
    expect(DecktetUtils.findCard("Ace of Wyrms")).not.toBeNull();
		expect(DecktetUtils.findCard("8 of Moons and Suns")).not.toBeNull();
		expect(DecktetUtils.findCard("8 of Suns and Moons")).not.toBeNull();
  });
  
  it("should build deck by names", function() {
		deck = DecktetUtils.makeDeck([
			"Ace of Waves", "4 of Wyrms and Knots", "4 of Waves and Leaves", "3 of Moons and Waves"
		]);
	
		expect(deck.length).toBe(4);
		expect(deck[0].rank).toBe("Ace");
		expect(deck[1].suits).toContain("Knots");
		
		nullCards = deck.filter(function(el) { return el == null });
		expect(nullCards.length).toBe(0);
  
  });
  
  it("should count suits", function() {
		deck = DecktetUtils.makeDeck([
			"2 of Moons and Knots", "3 of Moons and Waves", "4 of Moons and Suns"
		]);
		
		count = DecktetUtils.countBySuit(deck);
		expect(count['Moons']).toBe(3);
		expect(count['Suns']).toBe(1);
		expect(count['Knots']).toBe(1);
		expect(count['Waves']).toBe(1);
  });

  it("should count ranks", function() {
		deck = DecktetUtils.makeDeck([
			"2 of Moons and Knots", "3 of Moons and Waves", "2 of Waves and Leaves"
		]);
		
		count = DecktetUtils.countByRank(deck);
		expect(count['2']).toBe(2);
		expect(count['3']).toBe(1);
  });

	it("should detect shared suits", function() {
		deck = DecktetUtils.makeDeck(["2 of Moons and Knots", "3 of Moons and Waves", "4 of Moons and Suns"]);
		expect(DecktetUtils.shareOneSuit(deck)).toBe("Moons");
		
		deck = DecktetUtils.makeDeck(["9 of Moons and Suns", "Crown of Suns", "7 of Knots and Suns"]);
		expect(DecktetUtils.shareOneSuit(deck)).toBe("Suns");
		
		deck = DecktetUtils.makeDeck(["6 of Moons and Waves", "4 of Wyrms and Knots"]);
		expect(DecktetUtils.shareOneSuit(deck)).toBeNull();
	});

	it("should detect shared ranks", function() {
		deck = DecktetUtils.makeDeck(["Ace of Moons", "Ace of Waves", "Ace of Suns"]);
		expect(DecktetUtils.shareOneRank(deck)).toBe("Ace");
		
		deck = DecktetUtils.makeDeck(["9 of Moons and Suns", "Crown of Suns", "7 of Knots and Suns"]);
		expect(DecktetUtils.shareOneRank(deck)).toBe(null);
	});	

	it("should detect sequence of a suit", function() {
		deck = DecktetUtils.makeDeck(["Ace of Moons", "3 of Moons and Waves", "4 of Moons and Suns", "2 of Moons and Knots"]);
		expect(DecktetUtils.areConsecutiveRanks(deck)).toBe(true);
		
		deck = DecktetUtils.makeDeck(["Ace of Wyrms", "Crown of Wyrms", "9 of Wyrms and Waves"]);
		expect(DecktetUtils.areConsecutiveRanks(deck)).toBe(false);
	});
	
	it("should provide rank comparator utilities", function() {
		var comparator = DecktetUtils.rankComparator(Decktet.Ranks);
		expect(comparator("Ace of Wyrms", "Ace of Waves")).toBe(0);
		expect(comparator("Ace of Wyrms", "3 of Waves and Moons")).toBe(-2);
		expect(comparator("Crown of Wyrms", "3 of Waves and Moons")).toBe(7);
	});
	
});
