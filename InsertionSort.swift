//
//  InsertionSort.swift
//
//  Created by Atri Sarker
//  Created on 2025-11-09
//  Version 1.0
//  Copyright (c) 2025 Atri Sarker. All rights reserved.
//
//  Insertion Sort.
import Foundation

// Constant for the file path of the input file.
let inputFilePath = "./input.txt"
// Constant for the file path of the output file.
let outputFilePath = "./output.txt"

// Insertion Sort Function
// Sorts an array of integers using the insertion sort algorithm.
func insertionSort(_ array: [Int]) -> [Int] {
    var arr = array
    // Iterate over the threshold between sorted and unsorted
    for threshold in 1 ..< arr.count {
        // Store the current element
        let current = arr[threshold]
        // Start the insert index at the last sorted element
        var insertIndex = threshold - 1
        // Backtrack over the sorted partition
        // while the current element is less than the last sorted element
        while insertIndex >= 0 && arr[insertIndex] > current {
            // Shift the last sorted element to the right
            arr[insertIndex + 1] = arr[insertIndex]
            // Decrement the insert index
            insertIndex -= 1
        }
        // Insert the current element into its correct position
        arr[insertIndex + 1] = current
    }
    // Return the sorted array
    return arr
}

// Access the input file
guard let inputFile = FileHandle(forReadingAtPath: inputFilePath) else {
    print("CANNOT OPEN INPUT FILE")
    exit(1)
}

// Access the output file for writing
guard let outputFile = FileHandle(forWritingAtPath: outputFilePath) else {
    print("CANNOT OPEN OUTPUT FILE FOR WRITING")
    exit(1)
}

// Helper function for writing data
func writeToOutputFile(_ text: String) {
    if let data = text.data(using: .utf8) {
        outputFile.write(data)
    } else {
        print("Error: WRITING FAILED")
    }
}

// Read the contents of the input file
let inputData = inputFile.readDataToEndOfFile()

// Convert the data to a string
guard let inputString = String(data: inputData, encoding: .utf8) else {
    print("CANNOT CONVERT FILE DATA TO A STRING")
    exit(1)
}

// Create a list of all available lines
let listOfLines = inputString.components(separatedBy: .newlines)

// Loop through all the lines in the list
for line in listOfLines {
    // Check if the line is empty
    if line == "" {
        // If so, write an error message and continue
        writeToOutputFile("Error: No integers were found on this line.\n")
        continue
    }
    // Split the line
    let stringArr = line.split(separator: " ")
    // Convert String array into an int array
    var intArr = [Int]()
    for str in stringArr {
        if let num = Int(str) {
            intArr.append(num)
        }
    }
    // Print Array before Sorting
    print("Before: \(intArr)")
    // Sort the array
    let sortedArr = insertionSort(intArr)
    // Print Array after Sorting
    print("After: \(sortedArr)")

    // Write the sorted array to the output file
    for num in sortedArr {
        writeToOutputFile("\(num) ")
    }
    // Write a newline
    writeToOutputFile("\n")
}
