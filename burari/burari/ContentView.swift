//
//  ContentView.swift
//  burari
//
//  Created by user on 2023/06/12.
//

import SwiftUI
import CoreLocation
import BudouX




let locationManager = CLLocationManager()
//class見たなやつの親。内容とその型を宣言
//Identifiableを付与してインスタンスでid付けないとエラーになる。
struct Record:Identifiable {
    var id: Int
    let title:String
    let image:Image
    let place:String
    let phenomenon:String
    let detail:String
}

struct ContentView: View {
    
    @State var navigated = false
    
    @ObservedObject var manager = LocationManager()

        var body: some View {
            let latetude = $manager.location.wrappedValue.coordinate.latitude
            let longitude = $manager.location.wrappedValue.coordinate.longitude
            Text("\(latetude), \(longitude)").padding()
//        }
    
    //classのインスタンス化みたいなイメージ
    let records:[Record] = [
        .init(id:0 ,title: "霧の向こう側", image: Image("霧の向こう側"), place: "test", phenomenon: "淡い発光体の浮遊", detail: "歩いていると霧が深くなった。振り返るが霧で何も見えない。自然と前に進む足。すると前の方で奇妙な動きの発光を確認。発光体が近づいて思わず目を閉じる。目を開けたら見覚えのある景色。そして、夏の青空が広がっていた。"),
        .init(id:1,title: "境目", image:Image("境目"), place: "test", phenomenon: "気がつくたら空を逆さに歩いていた", detail: "海に行った。とても青が強くて印象的な空だった。あまりにも印象的で見入っていたら、違和感を覚えた。僕は逆さに空に立っていた。海が空で空が海だった。目を覚ますと砂浜で横になっていた。")
        
    ]
    
   
    
//    var body: some View {
        NavigationView{
            List{
//                Section(header:Text("怪奇一覧").font(.title2).tracking(2)){
                Section{
//                    HStack{
//                        Text("怪奇一覧").font(.title2).tracking(2)
//
//
//                    }.listRowBackground(Color.clear)
                    ForEach(records) { records in
                       
                        HStack{
                            NavigationLink(destination: RecordsDetail(records: records)){
                                records.image
                                    .resizable()
                                    .scaledToFill()
                                //写真を丸くする
                                    .clipShape(Circle())
                                    .frame(width:50,height: 50)
                                Text(records.title)
                                    .padding(.leading,20)
                            }
                        }
                    }
                }.navigationBarTitle(Text("怪奇一覧"),displayMode:.inline)
                    .navigationBarItems(
                        leading: Button(action: {}, label: {
                               Text("記憶を消す")
                           }),
                           trailing: HStack {
                               NavigationLink(
                                   destination: AddRecord(),
                                   isActive: $navigated,
                                   label: {
                                       Text("新たな怪奇")
                                   }
                               )
                           }
                        )
            }
        }
    }
    
    
    struct RecordsDetail:View {
        let records: Record
        
        var body:some View {
            NavigationView{
                ZStack{
                    records.image
                        .overlay(
                    VStack{
                        Text(records.title)
                            .font(.title2)
                            .padding(.bottom, 50)
                            .padding(.top, 40)
                            .tracking(2)
                       
                        Text(records.phenomenon)
//                            .padding(.bottom,10)
                            .tracking(2)
//                            .font(.custom("AmericanTypewriter-CondensedLight",size: 20))
                        BudouXText(records.detail)
//                            .frame(width:300,height: 300,alignment: .top)
                            .frame( maxWidth: 350, minHeight:50, maxHeight:500)
                            .multilineTextAlignment(.center)
                            .padding(.all,10)
                            .tracking(1)
//                            .font(.custom("AmericanTypewriter-CondensedLight",size: 20))
                        Text(records.place)
                            .tracking(2)
                            .padding(.bottom,50)
//                            .font(.custom("AmericanTypewriter-CondensedLight",size: 20))
                    }.frame(maxWidth: 350, minHeight:50, maxHeight:500, alignment: .top)
                        .background(Color.white.opacity(0.15)).cornerRadius(50).padding(.top, 350)
//                    records.image
                    ,alignment: .top)
                }
            }
//            }.navigationBarTitle(Text(records.title))
        }
    }
    
    
    struct AddRecord: View {
        @State var title = ""
        @State var phenomenon = ""
        @State var detail = ""
        @State var place = ""
        var body: some View {
            NavigationView{
                Form {
                    TextField("遭遇した怪奇",text: $title)
                    TextField("現象",text: $phenomenon)
                    TextField("詳細",text: $detail)
                    TextField("遭遇した場所",text: $place,axis: .vertical)
                }
                Button(action: {}) {
                    Text("報告")
                }
            }.navigationBarTitle("怪奇の報告")
        }
    }
    
        //navigastionlink用。選択すると次のページに飛ぶやつ。
        struct ContentView_Previews: PreviewProvider {
            static var previews: some View {
                ContentView()
            }
        }
    
}
//navigastionlink用。選択すると次のページに飛ぶやつ。
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
