//
//  GeometryAdjustmentFilters.swift
//  CIFilterKit
//
//  Created by Jeffrey Blagdon on 6/1/15.
//  Copyright (c) 2015 Jeffrey Blagdon. All rights reserved.
//

import Foundation

public func AffineTransform(inputTransform:CGAffineTransform) -> Filter {
    return { image in
        let parameters = [
            kCIInputImageKey: image,
            kCIInputTransformKey: inputTransform.value()
        ]
        let aFilter = CIFilter(name:FilterName.AffineTransform.rawValue, withInputParameters:parameters)
        return aFilter.outputImage
    }
}
public func Crop(inputRectangle:CGRect) -> Filter {
    return { image in
        let parameters = [
            kCIInputImageKey: image,
            "inputRectangle": inputRectangle.vector()
        ]
        let aFilter = CIFilter(name:FilterName.Crop.rawValue, withInputParameters:parameters)
        return aFilter.outputImage
    }
}

public func LanczosScaleTransform(options: LanczosScaleTransformOptions) -> Filter {
    return { image in
        let parameters = [
            kCIInputImageKey: image,
            kCIInputScaleKey: options.inputScale,
            kCIInputAspectRatioKey: options.inputAspectRatio
        ]
        let aFilter = CIFilter(name:FilterName.LanczosScaleTransform.rawValue, withInputParameters:parameters)
        return aFilter.outputImage
    }
}

public func PerspectiveCorrection(options: PerspectiveCorrectionOptions) -> Filter {
    return { image in
        let parameters = [
            kCIInputImageKey: image,
            "inputTopLeft": options.inputTopLeft.vector(),
            "inputTopRight": options.inputTopRight.vector(),
            "inputBottomLeft": options.inputBottomLeft.vector(),
            "inputBottomRight": options.inputBottomRight.vector()
        ]
        let aFilter = CIFilter(name:FilterName.PerspectiveCorrection.rawValue, withInputParameters:parameters)
        return aFilter.outputImage
    }
}
public func PerspectiveTile(options: PerspectiveCorrectionOptions) -> Filter {
    return { image in
        let parameters = [
            kCIInputImageKey: image,
            "inputTopLeft": options.inputTopLeft.vector(),
            "inputTopRight": options.inputTopRight.vector(),
            "inputBottomLeft": options.inputBottomLeft.vector(),
            "inputBottomRight": options.inputBottomRight.vector()
        ]
        let aFilter = CIFilter(name:FilterName.PerspectiveTile.rawValue, withInputParameters:parameters)
        return aFilter.outputImage
    }
}
public func PerspectiveTransform(options: PerspectiveCorrectionOptions) -> Filter {
    return { image in
        let parameters = [
            kCIInputImageKey: image,
            "inputTopLeft": options.inputTopLeft.vector(),
            "inputTopRight": options.inputTopRight.vector(),
            "inputBottomLeft": options.inputBottomLeft.vector(),
            "inputBottomRight": options.inputBottomRight.vector()
        ]
        let aFilter = CIFilter(name:FilterName.PerspectiveTransform.rawValue, withInputParameters:parameters)
        return aFilter.outputImage
    }
}
public func PerspectiveTransformWithExtent(options: PerspectiveCorrectionOptions, #inputExtent:CGRect?) -> Filter {
    return { image in
        var parameters = [
            kCIInputImageKey: image,
            "inputTopLeft": options.inputTopLeft.vector(),
            "inputTopRight": options.inputTopRight.vector(),
            "inputBottomLeft": options.inputBottomLeft.vector(),
            "inputBottomRight": options.inputBottomRight.vector()
        ]
        if let extent = inputExtent {
            parameters[kCIInputExtentKey] = extent.vector()
        }
        let aFilter = CIFilter(name:FilterName.PerspectiveTransformWithExtent.rawValue, withInputParameters:parameters)
        return aFilter.outputImage
    }
}
public func StraightenFilter(#inputAngle:Double?) -> Filter {
    return { image in
        var parameters: Parameters = [
            kCIInputImageKey: image
        ]
        if let angle = inputAngle {
            parameters[kCIInputAngleKey] = angle
        }
        let aFilter = CIFilter(name:FilterName.StraightenFilter.rawValue, withInputParameters:parameters)
        return aFilter.outputImage
    }
}