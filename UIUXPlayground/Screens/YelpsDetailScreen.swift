
import SwiftUI

struct YelpsDetailScreen: View {
    var body: some View {
        NavigationView {
            ScrollingItemDetailScreen(
                title: "Metro Diner",
                headerImage: UIImage(named: "metroexterior")
            ) {
                VStack(alignment: .leading, spacing: Paddings.normal) {
                    DoubleStackSubtitleText(
                        title1: "$$ • Breakfast",
                        title2: "Open now • 2:30pm - 6:00pm"
                    )
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, Paddings.normal)
                    .padding(.top, Paddings.normal)
                    
                    Text("A local breakfast spot with a variety of options.")
                        .padding(.horizontal, Paddings.normal)
                        .font(.footnote)
                    
                    HorizontalScrollingButtons(buttons: [
                        .init(title: "Add Review", icon: UIImage(systemName: "star.bubble")),
                        .init(title: "Map", backgroundColor: .white, foregroundColor: .black, borderColor: .gray, icon: UIImage(systemName: "map")),
                        .init(title: "Phone", backgroundColor: .white, foregroundColor: .black, borderColor: .gray, icon: UIImage(systemName: "phone")),
                        .init(title: "Website", backgroundColor: .white, foregroundColor: .black, borderColor: .gray, icon: UIImage(systemName: "rectangle.portrait.and.arrow.forward")),
                    ])
                    
                    Rectangle()
                        .fill(Color.gray.opacity(0.1))
                        .frame(height: Paddings.normal)
                    
                    InfoView(title: "Info") {
                        VStack(spacing: Paddings.normal) {
                            VStack(alignment: .leading, spacing: Paddings.xSmall) {
                                // TODO: Make into a reusable component
                                SubtitleText(title: "Hours")
                                
                                Text("Open until 7:00pm")
                                    .font(.footnote)
                                
                                Rectangle()
                                    .fill(Color.gray.opacity(0.1))
                                    .frame(height: 2)
                                    .padding(.top, Paddings.normal)
                            }
                            
                            VStack(alignment: .leading, spacing: Paddings.xSmall) {
                                SubtitleText(title: "Website")
                                
                                Text("metrodiner.com")
                                    .font(.footnote)
                                
                                Rectangle()
                                    .fill(Color.gray.opacity(0.1))
                                    .frame(height: 2)
                                    .padding(.top, Paddings.normal)
                            }
                            
                            VStack(alignment: .leading, spacing: Paddings.xSmall) {
                                SubtitleText(title: "Call")
                                
                                Text("(904 758-1234)")
                                    .font(.footnote)
                                
                                Rectangle()
                                    .fill(Color.gray.opacity(0.0))
                                    .frame(height: 2)
                            }
                        }
                    }
                    .padding(.horizontal, Paddings.normal)
                    
                    Rectangle()
                        .fill(Color.gray.opacity(0.1))
                        .frame(height: Paddings.normal)
                }
            }
        }
    }
}

#Preview {
    YelpsDetailScreen()
}
