//
//  ViewController.swift
//  CollectionViewLayout
//
//  Created by Julian Arias Maetschl on 15-02-21.
//

import UIKit

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(
            CustomCollectionViewCell.self,
            forCellWithReuseIdentifier: CustomCollectionViewCell.identifier
        )
        collectionView.register(
            CustomHeaderCollectionViewCell.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: CustomHeaderCollectionViewCell.identifier
        )
        collectionView.contentInset = UIEdgeInsets(top: 0.0, left: 15.0, bottom: 0.0, right: 0.0)
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CustomCollectionViewCell.identifier,
            for: indexPath
        ) as? CustomCollectionViewCell else {
            fatalError("Error creating CustomCollectionViewCell")
        }
        cell.backgroundColor = [UIColor.systemBlue, UIColor.red, UIColor.green, UIColor.yellow].randomElement()!
        cell.text = "Some title"
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let cell = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: CustomHeaderCollectionViewCell.identifier,
            for: indexPath
        ) as? CustomHeaderCollectionViewCell else { fatalError("") }
        cell.backgroundColor = .blue
        cell.title = "\(indexPath)"
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: 200.0, height: 58.0)
    }


}

class CustomCollectionViewCell: UICollectionViewCell {
    static let identifier: String =  "CustomCollectionViewCell"
    private let label = UILabel()

    var text: String = "" {
        didSet {
            addSubview(label)
            label.font = UIFont.systemFont(ofSize: 17.0)
            label.text = text
            setupConstraints()
        }
    }

    private func setupConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.widthAnchor.constraint(equalTo: widthAnchor, constant: -32.0).isActive = true
        label.heightAnchor.constraint(equalTo: heightAnchor, constant: -32.0).isActive = true
        layer.cornerRadius = 8.0
    }

}

class CustomHeaderCollectionViewCell: UICollectionReusableView {
    static let identifier: String =  "CustomHeaderCollectionViewCell"
    private let label = UILabel()

    var title: String = "" {
        didSet {
            addSubview(label)
            label.font = UIFont.systemFont(ofSize: 13.0)
            label.text = title
            setupConstraints()
        }
    }

    private func setupConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        label.topAnchor.constraint(equalTo: topAnchor, constant: 23.0).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8.0).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10.0).isActive = true
    }
}
