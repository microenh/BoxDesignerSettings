//
//  OpeningsDetail.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/1/22.
//

import SwiftUI

struct OpeningDetail: View {
    typealias Items = OpeningsView.Items

    @EnvironmentObject var items: Items
    @Binding var item: Items.Item?
    @State private var showModal = false
    @State private var delete = false

    var body: some View {
        if item != nil {
            VStack {
                // ScrollView(.vertical) {
                    Form {
                        TextField("Name", text: binding.name)
                    }
                    .frame(width: Misc.inputFormWidth)
                // }
                Canvas { context, size in
                    drawOpening(context: context, size: size)
                }
                Button {
                    showModal = true
                } label: {
                    Image(systemName: SystemImageNames.deleteItem)
                    Image(systemName: SystemImageNames.openings)
                }
            }
            .navigationTitle("Opening")
            .padding()
            .sheet(isPresented: $showModal) {
                if delete {
                    items.remove(item: item!)
                }
            } content: {
                DeletePrompt(message: "Delete \(binding.wrappedValue.description)?", delete: $delete)
            }
        }
    }
    
    private var binding: Binding<Items.Item> {
        Binding(get: { item! },
                set: { item! = $0 })
    }
    
    private func calcScale(size: CGSize) -> CGFloat {
        var xWidthPlus: CGFloat = 0.5
        var yWidthPlus: CGFloat = 0.5
        var xWidthMinus: CGFloat = -0.5
        var yWidthMinus: CGFloat = -0.5
        var holeXHalfWidth: CGFloat
        var holeYHalfWidth: CGFloat
        for hole in item!.detailItems.values {
            switch hole.type {
            case .circle, .square:
                holeXHalfWidth = hole.dimension1 / 2
                holeYHalfWidth = holeXHalfWidth
            case .ellipse, .rectangle, .capsule:
                holeXHalfWidth = hole.dimension1 / 2
                holeYHalfWidth = hole.dimension2 / 2
            }
            if hole.xOffset < 0 {
                xWidthMinus = min(xWidthMinus, hole.xOffset - holeXHalfWidth)
            } else {
                xWidthPlus = max(xWidthPlus, hole.xOffset + holeXHalfWidth)
            }
            if hole.yOffset < 0 {
                yWidthMinus = min(yWidthMinus, hole.yOffset - holeYHalfWidth)
            } else {
                yWidthPlus = max(yWidthPlus, hole.yOffset + holeYHalfWidth)
            }
        }
        return min((size.width - 10) / (xWidthPlus - xWidthMinus), (size.height - 10) / (yWidthPlus - yWidthMinus))
     }
    
    private func drawOpening(context: GraphicsContext, size: CGSize) {
        let centerX = size.width / 2
        let centerY = size.height / 2
        let scale = calcScale(size: size)
        var width: CGFloat
        var height: CGFloat
        for hole in item!.detailItems.values {
            switch hole.type {
            case .circle, .square:
                width = hole.dimension1
                height = width
            case .ellipse, .rectangle, .capsule:
                width = hole.dimension1
                height = hole.dimension2
            }
            let origin = CGPoint(x: centerX + (hole.xOffset - width / 2) * scale,
                                 y: centerY + (hole.yOffset - height / 2) * scale)
            let rect = CGRect(origin: origin, size: CGSize(width: width * scale, height: height * scale))
            
            var path: Path
            switch hole.type {
            case .circle, .ellipse:
                path = Path(ellipseIn: rect)
            case .square, .rectangle:
                path = Path(rect)
            case .capsule:
                path = Path(roundedRect: rect, cornerRadius: min(width, height) * scale / 2)
            }
            context.stroke(path, with: .color(.primary))
        }
        
    }

}

struct OpeningDetail_Previews: PreviewProvider {
    static var previews: some View {
        OpeningDetail(item: .constant(OpeningDetail.Items.Item()))
            .environmentObject(OpeningDetail.Items())
    }
}
