//
//  ColorAdjustmentFilters.swift
//  CIFilterKit
//
//  Created by Jeffrey Blagdon on 5/17/15.
//  Copyright (c) 2015 Jeffrey Blagdon. All rights reserved.
//

import Foundation

public func ColorClamp(options: ColorClampOptions) -> Filter {
    return { image in
        let parameters = [
            kCIInputImageKey: image,
            "inputMinComponents": options.inputMinComponents.vector(),
            "inputMaxComponents": options.inputMaxComponents.vector()
        ]
        let filter = CIFilter(name: FilterName.ColorClamp.rawValue, withInputParameters: parameters)
        return filter.outputImage
    }
}

public func ColorCrossPolynomial(options: ColorCrossPolynomialOptions) -> Filter {
    return { image in
        let parameters = [
            kCIInputImageKey: image,
            "inputRedCoefficients": options.inputRedCoefficients.vector(),
            "inputGreenCoefficients": options.inputGreenCoefficients.vector(),
            "inputBlueCoefficients": options.inputBlueCoefficients.vector()
        ]
        let filter = CIFilter(name:FilterName.ColorCrossPolynomial.rawValue, withInputParameters:parameters)
        return filter.outputImage
    }
}

public func ColorCube(inputCube:ColorCubeData) -> Filter {
    return { image in
        var optionalInputCubeDimension: Int? = nil
        var optionalData: NSData? = nil
        if countIsCube(inputCube.count) {
            let vectorArray = inputCube.map { [Float($0.r), Float($0.g), Float($0.b), Float($0.a)] }.reduce([], combine: +) as Array
            optionalInputCubeDimension = cubeRoot(inputCube.count)
            optionalData = NSData(bytes: vectorArray, length: vectorArray.count * sizeof(Float))
        }
        var parameters: Parameters = [
            kCIInputImageKey: image
        ]
        if let data = optionalData, dimension = optionalInputCubeDimension {
            parameters["inputCubeDimension"] = dimension
            parameters["inputCubeData"] = data
        }
        let filter = CIFilter(name: FilterName.ColorCube.rawValue, withInputParameters: parameters)
        return filter.outputImage
    }
}

//TODO: Need to make sure that the inputColorSpace cast provides expected behavior
public func ColorCubeWithColorSpace(inputCube:ColorCubeData, #inputColorSpace:CGColorSpaceRef) -> Filter {
    return { image in
        var optionalInputCubeDimension: Int? = nil
        var optionalData: NSData? = nil
        if countIsCube(inputCube.count) {
            let vectorArray = inputCube.map { [Float($0.r), Float($0.g), Float($0.b), Float($0.a)] }.reduce([], combine: +) as Array
            optionalInputCubeDimension = cubeRoot(inputCube.count)
            optionalData = NSData(bytes: vectorArray, length: vectorArray.count * sizeof(Float))
        }
        var parameters: Parameters = [
            kCIInputImageKey: image,
            "inputColorSpace": inputColorSpace
        ]
        if let data = optionalData, dimension = optionalInputCubeDimension {
            parameters["inputCubeDimension"] = dimension
            parameters["inputCubeData"] = data
        }
        let filter = CIFilter(name: FilterName.ColorCubeWithColorSpace.rawValue, withInputParameters: parameters)
        return filter.outputImage
    }
}


public func ColorInvert() -> Filter {
    return noParamsFilter(FilterName.ColorInvert.rawValue)
}

public func ColorMap(inputGradientImage:CIImage) -> Filter {
    return { image in
        let parameters = [
            kCIInputImageKey :image,
            "inputGradientImage": inputGradientImage
        ]
        let filter = CIFilter(name:FilterName.ColorMap.rawValue, withInputParameters:parameters)
        return filter.outputImage
    }
}

public func ColorMonochrome(options: ColorMonochromeOptions) -> Filter {
    return { image in
        let parameters = [
            kCIInputImageKey :image,
            kCIInputColorKey: options.inputColor,
            kCIInputIntensityKey: options.inputIntensity
        ]
        let filter = CIFilter(name:FilterName.ColorMonochrome.rawValue, withInputParameters:parameters)
        return filter.outputImage
    }
}

public func ColorPolynomial(options: ColorPolynomialOptions) -> Filter {
    return { image in
        let parameters = [
            kCIInputImageKey :image,
            "inputRedCoefficients": options.inputRedCoefficients.vector(),
            "inputGreenCoefficients": options.inputGreenCoefficients.vector(),
            "inputBlueCoefficients": options.inputBlueCoefficients.vector(),
            "inputAlphaCoefficients": options.inputAlphaCoefficients.vector()
        ]
        let filter = CIFilter(name:FilterName.ColorPolynomial.rawValue, withInputParameters:parameters)
        return filter.outputImage
    }
}
public func ColorPosterize(inputLevels:Double?) -> Filter {
    return { image in
        var parameters: Parameters = [
            kCIInputImageKey :image,
        ]
        if let levels = inputLevels {
            parameters["inputLevels"] = levels
        }
        let filter = CIFilter(name:FilterName.ColorPosterize.rawValue, withInputParameters:parameters)
        return filter.outputImage
    }
}

public func FalseColor(options: FalseColorOptions) -> Filter {
    return { image in
        let parameters = [
            kCIInputImageKey :image,
            "inputColor0": options.inputColor0,
            "inputColor1": options.inputColor1
        ]
        let filter = CIFilter(name:FilterName.FalseColor.rawValue, withInputParameters:parameters)
        return filter.outputImage
    }
}
public func MaskToAlpha() -> Filter {
    return noParamsFilter(FilterName.MaskToAlpha.rawValue)
}
public func MaximumComponent() -> Filter {
    return noParamsFilter(FilterName.MaximumComponent.rawValue)
}
public func MinimumComponent() -> Filter {
    return noParamsFilter(FilterName.MinimumComponent.rawValue)
}

public func PhotoEffectChrome() -> Filter {
    return noParamsFilter(FilterName.PhotoEffectChrome.rawValue)
}

public func PhotoEffectFade() -> Filter {
    return noParamsFilter(FilterName.PhotoEffectFade.rawValue)
}
public func PhotoEffectInstant() -> Filter {
    return noParamsFilter(FilterName.PhotoEffectInstant.rawValue)
}
public func PhotoEffectMono() -> Filter {
    return noParamsFilter(FilterName.PhotoEffectMono.rawValue)
}
public func PhotoEffectNoir() -> Filter {
    return noParamsFilter(FilterName.PhotoEffectNoir.rawValue)
}
public func PhotoEffectProcess() -> Filter {
    return noParamsFilter(FilterName.PhotoEffectProcess.rawValue)
}
public func PhotoEffectTonal() -> Filter {
    return noParamsFilter(FilterName.PhotoEffectTonal.rawValue)
}
public func PhotoEffectTransfer() -> Filter {
    return noParamsFilter(FilterName.PhotoEffectTransfer.rawValue)
}
public func SepiaTone(inputIntensity:Double?) -> Filter {
    return { image in
        var parameters: Parameters = [
            kCIInputImageKey: image
        ]
        if let intensity = inputIntensity {
            parameters["inputIntensity"] = inputIntensity
        }
        let filter = CIFilter(name:FilterName.SepiaTone.rawValue, withInputParameters:parameters)
        return filter.outputImage
    }
}

public func Vignette(options: VignetteOptions) -> Filter {
    return { image in
        let parameters = [
            kCIInputImageKey: image,
            kCIInputRadiusKey: options.inputRadius,
            kCIInputIntensityKey: options.inputIntensity
        ]
        let filter = CIFilter(name:FilterName.Vignette.rawValue, withInputParameters:parameters)
        return filter.outputImage
    }
}

public func VignetteEffect(options: VignetteEffectOptions) -> Filter {
    return { image in
        let parameters = [
            kCIInputImageKey: image,
            kCIInputCenterKey: options.inputCenter.vector(),
            kCIInputIntensityKey: options.inputIntensity,
            kCIInputRadiusKey: options.inputRadius,
            "inputFalloff": options.inputFalloff
        ]
        let filter = CIFilter(name:FilterName.VignetteEffect.rawValue, withInputParameters:parameters)
        return filter.outputImage
    }
}