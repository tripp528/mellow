
import SwiftUI
import MapKit

struct BlurView : UIViewRepresentable {
    var style : UIBlurEffect.Style
    func makeUIView(context: Context) -> UIVisualEffectView{
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        return view
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
    }
}

struct BottomSheet : View {
    // include these if you want to pass on the state  to the child views...?
    // @Binding var offset : CGFloat
    // var value : CGFloat
    
    let handle_height: CGFloat
    let content_height: CGFloat
    
    @Binding var selected_annotation : MKAnnotation?
    
    var body: some View {
        VStack {
            
            // drag handle
            Capsule()
                .fill(Color.gray.opacity(0.5))
                
                // pad around so that handle is correct height
                .frame(width: 50, height: 4)
                .padding(.top, (handle_height / 2) - 2)
                .padding(.bottom, (handle_height / 2) - 2)
            
            // testing annotation
            Text("\(Int(selected_annotation?.coordinate.latitude ?? 666))")
            
            // content
            BottomSheetContentView(height: content_height)
            
            Spacer()
        }
        // style the whole vstack background and corners 
        .background(BlurView(style: .systemMaterial))
        .cornerRadius(15)
    }
}


struct BottomSheet_Previews: PreviewProvider {
    static var previews: some View {
//        BottomSheet(offset: .constant(1000000), value: 2)
        BottomSheet(handle_height: 50, content_height: 100, selected_annotation: .constant(nil))
    }
}
