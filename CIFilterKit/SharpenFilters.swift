//
//  SharpenFilters.swift
//  CIFilterKit
//
//  Created by Jeffrey Blagdon on 6/2/15.
//  Copyright (c) 2015 Jeffrey Blagdon. All rights reserved.
//

import Foundation

public func SharpenLuminance(inputSharpness:Double?) -> Filter {
    return { image in
        var parameters: Parameters = [
            kCIInputImageKey: image
        ]
        if let sharpness = inputSharpness {
            parameters[kCIInputSharpnessKey] = sharpness
        }
        let filter = CIFilter(name: FilterName.SharpenLuminance.rawValue, withInputParameters: parameters)
        return filter.outputImage
    }
}

public func UnsharpMask(options: UnsharpMaskOptions) -> Filter {
    return { image in
        let parameters = [
            kCIInputImageKey: image,
            kCIInputRadiusKey: options.inputRadius,
            kCIInputIntensityKey: options.inputIntensity
        ]
        let filter = CIFilter(name: FilterName.UnsharpMask.rawValue, withInputParameters: parameters)
        return filter.outputImage
    }
}