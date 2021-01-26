
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
    @Binding var offset : CGFloat
    var value : CGFloat
    
    var body: some View {
        VStack {
            
            // drag handle
            Capsule()
                .fill(Color.gray.opacity(0.5))
                // 5 + 20 + 25 = 50px for handle area
                .frame(width: 50, height: 5)
                .padding(.top, 20)
                .padding(.bottom, 25)
            
            // content
            BottomSheetContentView()
        }
        // style the whole vstack background and corners 
        .background(BlurView(style: .systemMaterial))
        .cornerRadius(15)
    }
}


struct BottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheet(offset: .constant(1000000), value: 2)
    }
}
