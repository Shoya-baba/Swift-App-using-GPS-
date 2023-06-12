//
//  ContentView.swift
//  burari
//
//  Created by user on 2023/06/12.
//

import SwiftUI
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
    //classのインスタンス化みたいなイメージ
    let records:[Record] = [
        .init(id:0 ,title: "霧の向こう側", image: Image("霧の向こう側"), place: "test", phenomenon: "淡い発光体の浮遊", detail: "歩いていると霧が深くなった。振り返るが霧で何も見えない。自然と前に進む足。すると前の方で奇妙な動きの発光を確認。発光体が近づいて思わず目を閉じる。目を開けたら見覚えのある景色。そして、夏の青空が広がっていた。"),
        .init(id:1,title: "境目", image:Image("境目"), place: "test", phenomenon: "気がつくたら空を逆さに歩いていた", detail: "海に行った。とても青が強くて印象的な空だった。あまりにも印象的で見入っていたら、違和感を覚えた。僕は逆さに空に立っていた。海が空で空が海だった。目を覚ますと砂浜で横になっていた。")
        
    ]
    
    var body: some View {
        NavigationView{
            List{
                ForEach(records) { records in
                    HStack{
                        NavigationLink(destination: RecordsDetail()){
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
            }.navigationTitle(Text("境界"))
        }
        
    }
    
    struct RecordsDetail:View {
        var body:some View {
            Text("detail test")
        }
    }
    
  
    
        //navigastionlink用。選択すると次のページに飛ぶやつ。
        struct ContentView_Previews: PreviewProvider {
            static var previews: some View {
                ContentView()
            }
        }
    
}
