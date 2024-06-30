//
//  ContentView.swift
//  Pick-a-Pal
//
//  Created by SOOKYUNG CHO on 6/30/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var names: [String] = []

    @State private var nameToAdd = ""
    @State private var pickedName = ""
    @State private var shouldRemovePickedName = false
    
    var body: some View {
        VStack {
            VStack(spacing: 8){
                Image(systemName: "person.3.sequence.fill")
                    .foregroundStyle(.tint)
                    .symbolRenderingMode(.hierarchical)
                //ㅁㅊ? 이런게 되네?
                Text("Pick-a-Pal")
            }
            .font(.title)
            .bold()

            Text(pickedName.isEmpty ? " " : pickedName)
                .font(.title2)
                .bold()
                .foregroundStyle(.tint)
            //ternary conditional operator이란
            //let result = condition ? truevalue : falsevalue
            
            List{
                ForEach(names, id: \.self) //배열의 각 항목 자체가 고유 Id역할
                {
                    name in
                    Text(name)
                }
                //이건 ForEach 구문의 클로저 부분. 각 요소에 대해 수행할 작업을 작성
                //**in**은 클로저에서 매개변수와 클로저 본문을 구분!
                //기본형태: { (parameters) -> returnType in
                // 클로저 본문 }
                //ex) let sum = { (a:Int, b:Int) -> Int in
                //      return a+b }
                //매개변수: a,b이고 출력형태는 int, 실행 구문은 a+b
                //즉, name을 매개변수로 받고, text로 그 배열을 출력하는 클로저임
                
                //단축구문
                //ForEach(names, id: \.self){
                // Text($0) }
                
                
            }
            .clipShape(RoundedRectangle(cornerRadius: 8))
            TextField("Add name", text: $nameToAdd)
            //사용자가 값을 입력하면 nameToAdd의 값이 바뀌게 됨
            //Add name은 텍스트필드의 플레이스 홀더
                .autocorrectionDisabled()
                .onSubmit{ //사용자가 입력 후 제출(ex)키보드에서 리턴 키를 누르기)했을 때 실행할 작업을 정의하는 수정자.
                    if !nameToAdd.isEmpty{
                        names.append(nameToAdd)
                        //names에 사용자가 입력한 값 추가하고
                        nameToAdd = ""
                        //nameToAdd를 빈 문자열로 초기화함. TextField가 비워지도록 함.
                    }
                }
            
            Divider()
            
            Toggle("Remove when picked", isOn: $shouldRemovePickedName)
            //Remove when picked는 toggle의 라벨.
            //isOn: toggle의 상태를 제어하는 바인딩.
            //$shouldRemovePickedName은 true, false로 변경됨
            
            Button{
                if let randomName = names.randomElement(){
                    pickedName = randomName
                    
                    if shouldRemovePickedName{
                        //toggle로부터 받아온 값이 true인지 확인함.
                        names.removeAll {name in
                            //names 리스트에서 선택된 이름을 제거
                            return (name == randomName)
                            //randomName과 일치하는 이름을 리스트에서 제거함
                        }
                    }
                } else{
                    pickedName = ""
                }
            } label: {
                Text("Pick Random Name")
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
            }
            .buttonStyle(.borderedProminent)
            .font(.title2)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
