//
//  SongsCollectionViewCell.swift
//  iTunesTask
//
//  Created by Bakhtiyarov Fozilkhon on 23.06.2023.
//

import Foundation
import UIKit

class SongsCollectionViewCell: UICollectionViewCell {
    
    let nameSongLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        
        return label
    }()
    
    private lazy var songNote: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "music.note")
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setCell()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setCell() {
        
        [nameSongLabel, songNote].forEach {
            addSubview($0)
        }
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 12
        self.backgroundColor = .white
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            songNote.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            songNote.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 7)
        ])
    
        NSLayoutConstraint.activate([
            nameSongLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            nameSongLabel.leadingAnchor.constraint(equalTo: songNote.trailingAnchor, constant: 5),
            nameSongLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
        ])
    }
}


