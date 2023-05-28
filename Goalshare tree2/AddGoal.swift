//
//  AddGoal.swift
//  Goalshare tree2
//
//  Created by Josh Chou on 12/20/22.
//

import SwiftUI
import Foundation
import Combine
import FirebaseFirestore

struct AddGoal: View {
    enum FocusedField {
        case goalTitle
    }
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    @EnvironmentObject var account: Account
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var keyboardObserver = KeyboardObserver()
    @State private var goalTitle = ""
    @State private var goalDescription = ""
    @State private var goalCompletionDate = Date()
    @State private var show = true
    @State private var complete = false
    @State private var isPhotoLibraryDisplay = false
    @State private var isCameraDisplay = false
    @State private var isChecked = false
    @State public var selectedImage: UIImage?
    @FocusState private var focusedBox: Bool
    @FocusState private var focusedField: FocusedField?
    @State private var sourceType: UIImagePickerController.SourceType? = nil
    
    @Namespace var namespace
    var textLimit = 16
    var body: some View {
        GeometryReader {_ in
            ZStack {
                Color.clear
                    .onTapGesture {
                        hideKeyboard()
                    }
                    .ignoresSafeArea(.all)
                VStack(alignment: .leading) {
                    HStack (alignment: .top) {
                        VStack(alignment: .leading) {
                            Text("     Add goal")
                                .font(.custom("Lexend-semiBold", size: 22))
                                .scaleEffect(1.5)
                                .onReceive(Just(goalTitle)) { _ in limitText(textLimit) }
                            TextField("Enter goal here", text: $goalTitle, axis: .vertical)
                                .font(.custom("Lexend-semiBold", size: 14))
                                .lineLimit(2...)
                                .frame(height: 70)
                                .padding()
                                .onReceive(Just(goalTitle)) { _ in limitText(textLimit) }
                        }
                        Spacer()
                        if selectedImage != nil {
                            Image(uiImage: selectedImage!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 150, height: 150)
                                .clipShape(Circle())
                                .overlay {
                                    Circle()
                                        .stroke(.black, lineWidth: 4)
                                }
                        }
                        else {
                            ZStack {
                                Circle()
                                    .fill(Color(red: 0.898, green: 0.898, blue: 0.89607))
                                    .frame(width: 180, height: 180)
                                Image(systemName: "plus")
                                    .resizable()
                                    .foregroundColor(.yellow)
                                    .frame(width: 110, height: 110)
                            }
                            
                        }
                    }
                    .frame(maxWidth: .infinity)
                    
                    
                    VStack(alignment:.leading, spacing: 30) {
                        Toggle(isOn: $isChecked) {
                            Text("Update Goal Picture to be most recent milestone")
                                .font(.custom("lexend-semiBold", size: 14))
                        }
                        .padding()
                        .toggleStyle(CheckboxToggleStyle())
                        DatePicker("Goal Completion Date", selection: $goalCompletionDate, in: Date()..., displayedComponents: .date)
                            .padding()
                        
                        HStack(alignment: .center, spacing: 70) {
                            Button {
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Text("Cancel")
                                    .font(.custom("lexend-semiBold", size: 16))
                                    .padding()
                                    .frame(width: 120)
                                    .foregroundColor(.red)
                                    .background(Color(red: 0.378, green: 0.378, blue: 0.377))
                                    .cornerRadius(20)
                            }
                            Button(action: {
                                var conditionIsMet = false
                                if (!goalTitle.isEmpty) {
                                    conditionIsMet = true
                                }
                                if conditionIsMet {
                                    let db = Firestore.firestore()
                                    let newGoalRef = db.collection("accounts").document(account.id).collection("goals").document()
                                    newGoalRef.setData([
                                        "id": newGoalRef.documentID,
                                        "name": goalTitle,
                                        "date": goalCompletionDate,
                                        "pin": false
                                    ]) { error in
                                        if let error = error {
                                            print("Error adding goal: \(error)")
                                        } else {
                                            print("Goal successfully added!")
                                            
                                            let newGoal = Goal(id: newGoalRef.documentID, name: goalTitle, date: goalCompletionDate, pin: false)
                                            account.goals.append(newGoal)
                                            
                                            presentationMode.wrappedValue.dismiss()
                                        }
                                    }
                                } else {
                                    print("Condition not met")
                                }
                            }) {
                                Text("Add Goal!")
                                    .font(.custom("lexend-semiBold", size: 16))
                                    .foregroundColor(.yellow)
                                    .padding()
                                    .frame(width: 120)
                                    .background(Color(red: 0.378, green: 0.378, blue: 0.377))
                                    .cornerRadius(20)
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                    Spacer()
                }
                .background(Color(red: 0.998, green: 0.998, blue: 0.99607))
                .padding(.bottom, keyboardObserver.keyboardHeight)
                .ignoresSafeArea(.keyboard)
            }
        }
    }
    func limitText(_ upper: Int) {
        if goalTitle.count > upper {
            goalTitle = String(goalTitle.prefix(upper))
        }
    }
}
struct CustomDatePicker: UIViewRepresentable {
    @Binding var date: Date
    
    func makeUIView(context: Context) -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.addTarget(context.coordinator, action: #selector(Coordinator.dateChanged(_:)), for: .valueChanged)
        return datePicker
    }
    
    func updateUIView(_ uiView: UIDatePicker, context: Context) {
        uiView.date = date
        if let font = UIFont(name: "Lexend-semiBold", size: 14) {
            UILabel.appearance(whenContainedInInstancesOf: [UIDatePicker.self]).font = font
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject {
        var parent: CustomDatePicker
        
        init(_ parent: CustomDatePicker) {
            self.parent = parent
        }
        
        @objc func dateChanged(_ sender: UIDatePicker) {
            parent.date = sender.date
        }
    }
}
struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            
            Spacer()
            
            Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(configuration.isOn ? .blue : .gray)
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
    }
}

// Just for visuals, note id is empty
struct AddGoal_Previews: PreviewProvider {
    static var previews: some View {
        AddGoal()
            .environmentObject(Account(id: ""))
    }
}
