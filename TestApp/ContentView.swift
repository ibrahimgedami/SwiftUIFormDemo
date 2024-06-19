//
//  ContentView.swift
//  TestApp
//
//  Created by Ibrahim Gedami on 14/05/2024.
//

import SwiftUI
import Combine
import SwiftUIPresentationView

class FormViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var birthday: Date = Date()
    @Published var enableNotifications: Bool = false
    @Published var volume: Double = 5.0
    @Published var email: String = ""
    @Published var password: String = ""
    
}

struct SecureTextField: View {
    
    var placeholder: String
    @Binding var text: String
    @State private var isEditing: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if !isEditing && text.isEmpty {
                SecureField(placeholder, text: $text)
                    .padding(12)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .foregroundColor(.black)
                    .padding(.horizontal, 4)
            } else {
                Text(placeholder)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 4)
                    .offset(y: -18)
                    .scaleEffect(0.8, anchor: .leading)
                    .transition(.move(edge: .top))
                
                SecureField("", text: $text, onCommit: {
                    isEditing = false
                })
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .foregroundColor(.black)
                .onTapGesture {
                    withAnimation {
                        isEditing = true
                    }
                }
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 16)
    }
    
}

struct CustomTextField: View {
    
    var placeholder: String
    @Binding var text: String
    @State private var isEditing: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if !isEditing && text.isEmpty {
                TextField(placeholder, text: $text)
                    .padding(12)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .foregroundColor(.black)
                    .padding(.horizontal, 4)
            } else {
                Text(placeholder)
                    .font(.title3)
                    .foregroundColor(.brown)
                    .padding(0)
                    .offset(y: -18)
                    .scaleEffect(0.8, anchor: .leading)
                    .transition(.move(edge: .top))
                
                TextField("", text: $text, onCommit: {
                    isEditing = false
                })
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .foregroundColor(.black)
                .onTapGesture {
                    withAnimation {
                        isEditing = true
                    }
                }
            }
        }
    }
    
}

struct CustomDatePicker: View {
    
    var placeholder: String
    @Binding var date: Date
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(placeholder)
                .font(.caption)
                .foregroundColor(.gray)
            DatePicker("", selection: $date, displayedComponents: .date)
                .labelsHidden()
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.blue, lineWidth: 1)
                )
        }
        .padding(.vertical, 5)
    }
    
}

struct CustomToggle: View {
    
    var title: String
    @Binding var isOn: Bool
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Toggle("", isOn: $isOn)
                .labelsHidden()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.blue, lineWidth: 1)
        )
        .padding(.vertical, 5)
    }
    
}

struct DropDownListViewControllerWrapper<DataModel: Displayable & Searchable>: UIViewControllerRepresentable {
    
    var dataSource: [DataModel]
    var onSelection: (DataModel?) -> Void

    func makeUIViewController(context: Context) -> DropDownListViewController {
        guard let viewController = DropDownListConfiguration.search(dataSource).viewController as? DropDownListViewController else {
            fatalError("Unable to instantiate DropDownListViewController")
        }
        viewController.closure = { selectedItem in
            onSelection(selectedItem as? DataModel)
        }
        return viewController
    }

    func updateUIViewController(_ uiViewController: DropDownListViewController, context: Context) {
        // Update the view controller if needed
    }
    
}

struct CustomDropdownList: View {
    @State private var selectedItem: DropdownItem?
    @State private var isPresented = false
    private var items: [DropdownItem] = [
        DropdownItem(label: "Option 1"),
        DropdownItem(label: "Option 2"),
        DropdownItem(label: "Option 3"),
        DropdownItem(label: "Option 4")
    ]
    
    var body: some View {
        VStack {
            HStack {
                Text(selectedItem?.displayedText ?? "Select an option")
                    .foregroundColor(selectedItem == nil ? .gray : .black)
                Spacer()
                Button(action: {
                    isPresented.toggle()
                }, label: {
                    Image(systemName: "chevron.down")
                        .foregroundColor(.gray)
                })
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
        }
        .padding()
        .present(isPresented: $isPresented,
                 style: .popover.backgroundColor(UIColor(cgColor:  UIColor.systemBackground.cgColor))
        ) {
            DropDownListViewControllerWrapper(dataSource: items) { selected in
                self.selectedItem = selected
                self.isPresented = false
            }
        }
//        .sheet(isPresented: $isPresented) {
//            DropDownListViewControllerWrapper(dataSource: items) { selected in
//                self.selectedItem = selected
//                self.isPresented = false
//            }
//        }
    }
    
}

struct DropdownItem: Displayable, Searchable {
        
    var id = UUID()
    var label: String
    
    var displayedText: String? {
        return label
    }
    
    var searchText: String? {
        return label
    }
    
    var object: Self? {
        self
    }
    
}

struct DropdownRow: View {
    
    var item: DropdownItem
    
    var body: some View {
        HStack {
            Text(item.label)
                .font(.body)
                .foregroundColor(.black)
            Spacer()
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
        .shadow(color: .gray, radius: 2, x: 0, y: 1)
    }
    
}

struct ContentView: View {
    
    @StateObject var viewModel = FormViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Custom Form in SwiftUI")
                    .font(.largeTitle)
                    .padding(.top, 20)
                CustomTextField(placeholder: "Name", text: $viewModel.name)
                    .padding(.horizontal)
                CustomDatePicker(placeholder: "Birthday", date: $viewModel.birthday)
                    .padding(.horizontal)
                CustomToggle(title: "Enable Notifications", isOn: $viewModel.enableNotifications)
                    .padding(.horizontal)
                CustomTextField(placeholder: "Email", text: $viewModel.email)
                    .padding(.horizontal)
                SecureTextField(placeholder: "Password", text: $viewModel.password)
                    .padding(.horizontal)
                CustomDropdownList()
                    .padding(.horizontal)
                Button(action: submitButtonTapped) {
                    Text("Submit")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 0)
                .padding(.vertical, 8)
            }
            .padding(.horizontal)
        }
    }
    
    func submitButtonTapped() {
        print("Form values:")
        print("Name: \(viewModel.name)")
        print("Birthday: \(viewModel.birthday)")
        print("Enable Notifications: \(viewModel.enableNotifications)")
        print("Email: \(viewModel.email)")
        print("Password: \(viewModel.password)")
    }
    
}

// Custom SwiftUI View for Popover-like Behavior
struct PopoverLikeView<Content: View>: View {
    
    @Binding var isPresented: Bool
    let content: Content
    let size: CGSize
    let arrowDirection: UIPopoverArrowDirection
    
    var body: some View {
        ZStack {
            if isPresented {
                GeometryReader { geometry in
                    VStack {
                        Spacer()
                        content
                            .frame(width: size.width, height: size.height)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    .edgesIgnoringSafeArea(.all)
                    .transition(.move(edge: .bottom))
                }
                .onTapGesture {
                    withAnimation {
                        isPresented = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
    
}
