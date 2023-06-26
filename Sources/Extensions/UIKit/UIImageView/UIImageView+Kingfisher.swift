//
//  File.swift
//  
//
//  Created by Semen Kologrivov on 26.05.2023.
//

import UIKit
import Kingfisher

public typealias ImageDownloadedCompletion = (_ success: Bool, _ image: UIImage?) -> Void

extension SQExtensions where Base == UIImageView {

    @discardableResult
    public func setImage(
        fromURL url: URL?,
        withPlaceholder placeholder: UIImage? = nil,
        failureImage: UIImage? = nil,
        animated: Bool = false,
        keepPng: Bool = false,
        templateImage: Bool = false,
        completion: ImageDownloadedCompletion? = nil
    ) -> DownloadTask? {
        guard let url = url else {
            completion?(false, nil)
            self.base.image = failureImage
            return nil
        }

        var options: [KingfisherOptionsInfoItem] = [
            .cacheOriginalImage,
            .keepCurrentImageWhileLoading,
            .callbackQueue(.mainAsync)
        ]

        let cacheKey = url.absoluteString

        let resource = ImageResource(
            downloadURL: url,
            cacheKey: cacheKey
        )

        if animated {
            options.append(
                .transition(
                    ImageTransition.fade(0.3)
                )
            )
        }

        if keepPng {
            options.append(
                .cacheSerializer(
                    FormatIndicatedCacheSerializer.png
                )
            )
        }

        let imageView = self.base

        let currentPlaceholder = KingfisherManager.shared.cache.retrieveImageInMemoryCache(forKey: cacheKey) ?? placeholder

        return self.base.kf.setImage(
            with: resource,
            placeholder: currentPlaceholder,
            options: options,
            progressBlock: { (_, _) in },
            completionHandler: { [weak imageView] (result) in
                switch result {

                case .success(let result):
                    var image = result.image
                    if templateImage {
                        image = image.withRenderingMode(.alwaysTemplate)
                        imageView?.image = image
                    }
                    completion?(true, image)

                case .failure(let error):
                    if error.isNotCurrentTask { return }

                    completion?(false, nil)
                    imageView?.image = failureImage
                }
            })
    }
}
