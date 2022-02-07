import Foundation

class ToJson {
    // convert from coco json to create ML json
    func cocoJsonToCreateMLJson(_ filepath: String) -> Void {
        //coco json
        let fromFileURL = URL(fileURLWithPath: filepath)
        
        let data = try? Data(contentsOf: fromFileURL)
        
        if let coco = try? JSONDecoder().decode(COCOFormat.self, from: data!),
           let cocoImages = coco.images {
            
            // dictionary of images
            var cocoImagesDict = Dictionary<Int, String>()
            // fill dictionary of images
            for cocoImage in cocoImages {
                cocoImagesDict[cocoImage.id] = cocoImage.fileName
            }
            
            // dictionary of labels
            var cocoLabelsDict = Dictionary<Int, String>()
            if let cocoLabels = coco.categories {
                // fill dictionary of labels
                for cocoLabel in cocoLabels {
                    cocoLabelsDict[cocoLabel.id] = cocoLabel.name
                }
            }
            
            // create ML object
            var toJson : [CMLFormat]?
            
            // array of annotations
            if let cocoAnnotations = coco.annotations {
                for cocoAnnotation in cocoAnnotations {
                    if let categoryId = cocoAnnotation.categoryId,
                       let bbox = cocoAnnotation.bbox {
                        
                        toJson = toJson ?? Array<CMLFormat>()
                        
                        toJson!.append(CMLFormat(annotation:
                                    [Annotation(coordinates:
                                                Coordinates(x: (bbox[0] + bbox[2]),
                                                            y: (bbox[1] + bbox[3]),
                                                            width: 2*bbox[2],
                                                            height: 2*bbox[3]),
                                               label:
                                                cocoLabelsDict[categoryId])],
                                  images:
                                    cocoImagesDict[cocoAnnotation.imageId]))
                    }
                }
            }
            
            // write ML object to drive
            if let theJSONData = try? JSONEncoder().encode(toJson),
               let theJSONText = String(
                data: theJSONData,
                encoding: String.Encoding.utf8) {
            
                print("JSON string = \n\(theJSONText)")
                let toFileURL = fromFileURL
                print("\(toFileURL) updated!" )
                
                //writing
                do {
                    try theJSONText.write(to: toFileURL, atomically: true, encoding: String.Encoding.utf8)
                }
                catch {
                    /* error handling here */
                    print("cannot perform write file")
                }
            }
        }
    }

    
    // convert from vott json to create ML json
    func vottJsonToCreateMLJson(_ filepath: String) -> Void {
        //vott json
        let fromFileURL = URL(fileURLWithPath: filepath)
        //let filepath = Bundle.main.path(forResource: "hansoong2-export", ofType: "json")
        
        let data = try? Data(contentsOf: fromFileURL)
        let json = try? JSONSerialization.jsonObject(with: data!, options: [])

        //create ML json
        var toJson = [[String:Any]]()
        
        if let jsonRoot = json as? [String: Any] {
            if let assets = jsonRoot["assets"] as? [String: Any] {
                for (_, value) in assets {
                    if let content = value as? [String : Any] {
                        if let asset = content["asset"] as? [String: Any], let regions = content["regions"] as? Array<Any> {
                            var jsonItem = [String:Any]()
                            jsonItem["images"] = (asset["name"] as! String)
                            
                            var annotations = [[String:Any]]()
                            
                            for item in regions {
                                var annotationItem = [String:Any]()
                                
                                let region = item as! [String:Any]
                                let labels = region["tags"] as! [String]
                                annotationItem["label"] = labels.first
                                
                                let boundingBox = region["boundingBox"] as! [String:Double]
                                let left = boundingBox["left"]!
                                let top = boundingBox["top"]!
                                let width = boundingBox["width"]!
                                let height = boundingBox["height"]!
                                
                                annotationItem["coordinates"] = [
                                    "x" : Int(left + width / 2),
                                    "y" : Int(top + height / 2),
                                    "width" : Int(width),
                                    "height" : Int(height)
                                ]
                                
                                annotations.append(annotationItem)
                            }
                            jsonItem["annotation"] = annotations
                            
                            toJson.append(jsonItem)
                            
                            //print(regions)
                            
                        }
                    }
                }

            }
        }
        if let theJSONData = try?
            JSONSerialization.data(
                withJSONObject: toJson,
                options: .prettyPrinted
              ),
           let theJSONText = String(
            data: theJSONData,
            encoding: String.Encoding.utf8)
        {
            print("JSON string = \n\(theJSONText)")
            let toFileURL = fromFileURL
            print("\(toFileURL) updated!" )
                //writing
                do {
                    try theJSONText.write(to: toFileURL, atomically: true, encoding: String.Encoding.utf8)
                }
                catch {
                    /* error handling here */
                    print("cannot perform write file")
                    
                }
            //}

        }
    }
}

//let filename = "annotation.json"
//if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
//let downloadURL = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first!
//let toFileURL = downloadURL.appendingPathComponent(filename)
//let toFileURL = fromFileUrl.deletingLastPathComponent().appendingPathComponent(filename)
