import SwiftUI

struct PersonLoginView: View {
    @State private var phone = ""
    @State private var password = ""
    @State private var bannerMessage = ""
    @State private var showBanner = false
    @State private var navigateToCV = false
    
    var personModel = PersonModel()
    var tagsModel = TagsModel()
    @State var seleccionadosT = Set<String>()
    
    var body: some View {
        
            ScrollView {
                VStack {
                    
//                    if showBanner {
//                        BannerView(message: bannerMessage)
//                            .opacity(showBanner ? 1 : 0)
//                            .animation(.easeInOut(duration: 2))
//                            .onAppear {
//                                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//                                    self.showBanner = false
//                                }
//                            }
//                    }
                    
                    Image("logoApp")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                    
                    Text("Login")
                        .font(.largeTitle)
                        .padding()
                    
                    VStack(alignment: .leading, spacing: 10){
                        
                        Text("Phone*")
                        TextField("Phone", text: $phone)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1))
                        
                        Text("Password*")
                        TextField("password", text: $password)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1))
                        
                    }
                    
                    NavigationLink(destination: ContentView(selectedT: seleccionadosT, personModel: personModel), isActive: $navigateToCV) {
                        EmptyView()
                    }
                    

                    
                    Button(action: {
                        print("printing in lofiin view")
                        personModel.login(phone: phone, password: password) { success, person, error in
                            if success {
                                //print(person)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                                    self.personModel.fetchedPerson = person
                                    self.navigateToCV = true
                                }
                            }else{
                                print("Not succesful")
                            }
                            print(personModel.fetchedPerson)
                        }
                        
                    }) {
                        Text("Login")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(hex: "625C87"))
                            .cornerRadius(10)
                            .padding(.horizontal)
                            .onAppear(){
                                tagsModel.fetchTags()
                            }
                            
                    }
                    
                    .padding(.top)
                    
                    Spacer()
                    
                }
                .padding()
            }
            .onAppear(){
                tagsModel.fetchTags()
            }
        }
        
    }
        


struct PersonLoginView_Previews: PreviewProvider {
    static var previews: some View {
        PersonLoginView()
    }
}

//struct BannerView: View {
//    var message: String
//    
//    var body: some View {
//        Text(message)
//            .padding()
//            .frame(maxWidth: .infinity)
//            .background(Color(hex: "625C87"))
//            .foregroundColor(.white)
//    }
//}
