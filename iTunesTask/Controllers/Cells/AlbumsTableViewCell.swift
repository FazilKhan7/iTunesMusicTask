//
//  AlbumsTableViewCell.swift
//  iTunesTask
//
//  Created by Bakhtiyarov Fozilkhon on 23.06.2023.
//

import Foundation
import UIKit
import SnapKit

class AlbumsTableViewCell: UITableViewCell {
    
    static let reuseId = "Cell"
    
    private lazy var albumLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var albumNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name album name"
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var artistNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name artist name"
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var trackCountLabel: UILabel = {
        let label = UILabel()
        label.text = "16 tracks"
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var stackView = UIStackView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        albumLogo.layer.cornerRadius = albumLogo.frame.width / 2
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        self.addSubview(albumLogo)
        self.addSubview(albumNameLabel)
        
        stackView = UIStackView(arrangedSubviews: [artistNameLabel, trackCountLabel],
                                axis: .horizontal,
                                spacing: 10,
                                distribution: .equalCentering)
        self.addSubview(stackView)
    }
    
    func configureCell(album: Album) {
        
        if let urlImageString = album.artworkUrl100 {
            NetworkRequest.shared.requestData(urlString: urlImageString) { [weak self] result in
                switch result {
                case .success(let data):
                    let image = UIImage(data: data)
                    self?.albumLogo.image = image
                case .failure(_):
                    self?.albumLogo.image = nil
                }
            }
        }else{
            albumLogo.image = nil
        }
        
        albumNameLabel.text = album.collectionName
        artistNameLabel.text = album.artistName
        trackCountLabel.text = "\(album.trackCount) tracks"
    }
    
    private func setConstraints() {
        albumLogo.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(15)
            make.width.height.equalTo(60)
        }
        
        albumNameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(10)
            make.leading.equalTo(albumLogo.snp.trailing).offset(10)
            make.trailing.equalTo(self.snp.trailing).offset(-10)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(albumNameLabel.snp.bottom).offset(10)
            make.leading.equalTo(albumLogo.snp.trailing).offset(10)
            make.trailing.equalTo(self.snp.trailing).offset(-10)
        }
    }
}
