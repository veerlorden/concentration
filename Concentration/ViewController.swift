//
//  ViewController.swift
//  Concentration
//
//  Created by Вадим Буркин on 07.11.2021.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentTheme()
        updateViewFromModel()
    }
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        (cardButtons.count + 1) / 2
    }

    @IBOutlet private weak var restartButton: UIButton!
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card is not in cardButtons")
        }
    }
    
    @IBAction private func startNewGame() {
        game.reset()
        currentTheme()
        updateViewFromModel()
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = UIColor.white
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? UIColor.clear : cardColor
            }
        }
        scoreLabel.text = "Score: \(game.score)"
        flipCountLabel.text = "Flips: \(game.flipCount)"
    }
    
    private var emojiChoices = [String]()
    private var emoji = [Int: String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int.random(in: 0 ..< emojiChoices.count)
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    private func currentTheme() {
        let randomIndex = Int.random(in: 0 ..< themes.count)
        let theme = themes[randomIndex]
        emojiChoices = theme.emojis
        backgroundColor = theme.backgroundColor
        cardColor = theme.cardColor
        titleLabel.text = theme.name
        emoji = [:]
        
        updateAppearance()
    }
    
    private var backgroundColor: UIColor?
    private var cardColor: UIColor?
    
    private func updateAppearance() {
        view.backgroundColor = backgroundColor
        titleLabel.textColor = cardColor
        flipCountLabel.textColor = cardColor
        scoreLabel.textColor = cardColor
        restartButton.setTitleColor(backgroundColor, for: .normal)
        restartButton.backgroundColor = cardColor
    }
    
    private struct Theme {
        let name: String
        let emojis: [String]
        let backgroundColor: UIColor
        let cardColor: UIColor
    }

    private var themes = [
        Theme(name: "Halloween",
              emojis: ["💀", "👻", "👽", "🙀", "🦇", "🕷", "🕸", "🎃", "🎭","😈", "⚰"],
              backgroundColor: UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1.00),
              cardColor: UIColor(red: 1.00, green: 0.50, blue: 0.00, alpha: 1.00)),
        Theme(name: "Fruits",
              emojis: ["🍏", "🍊", "🍓", "🍉", "🍇", "🍒", "🍌", "🥝", "🍆", "🍑", "🍋"],
              backgroundColor: UIColor(red: 0.96, green: 0.96, blue: 0.86, alpha: 1.00),
              cardColor: UIColor(red: 0.31, green: 0.78, blue: 0.47, alpha: 1.00)),
        Theme(name: "Faces",
              emojis: ["😀", "😂", "🤣", "😃", "😄", "😅", "😆", "😉", "😊", "😋", "😎"],
              backgroundColor: UIColor(red: 1.00, green: 0.75, blue: 0.80, alpha: 1.00),
              cardColor: UIColor(red: 0.65, green: 0.16, blue: 0.16, alpha: 1.00)),
        Theme(name: "Animals",
              emojis: ["🐶", "🐭", "🦊", "🦋", "🐢", "🐸", "🐵", "🐞", "🐿", "🐇", "🐯"],
              backgroundColor: UIColor(red: 0.80, green: 0.52, blue: 0.25, alpha: 1.00),
              cardColor: UIColor(red: 0.99, green: 0.92, blue: 0.66, alpha: 1.00)),
        Theme(name: "Christmas",
              emojis: ["🎅", "🎉", "🦌", "⛪️", "🌟", "❄️", "⛄️","🎄", "🎁", "🔔", "🕯"],
              backgroundColor: UIColor(red: 0.00, green: 0.75, blue: 1.00, alpha: 1.00),
              cardColor: UIColor(red: 0.00, green: 0.00, blue: 0.50, alpha: 1.00)),
        Theme(name: "Transport",
              emojis: ["🚗", "🚓", "🚚", "🏍", "✈️", "🚜", "🚎", "🚲", "🚂", "🛴"],
              backgroundColor: UIColor(red: 0.50, green: 1.00, blue: 0.00, alpha: 1.00),
              cardColor: UIColor(red: 0.00, green: 0.00, blue: 0.50, alpha: 1.00))
    ]
    
}

